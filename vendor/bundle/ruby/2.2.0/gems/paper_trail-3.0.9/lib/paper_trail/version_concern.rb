require 'active_support/concern'

module PaperTrail
  module VersionConcern
    extend ::ActiveSupport::Concern

    included do
      belongs_to :item, :polymorphic => true
      validates_presence_of :event
      attr_accessible :item_type, :item_id, :event, :whodunnit, :object, :object_changes if PaperTrail.active_record_protected_attributes?

      after_create :enforce_version_limit!
    end

    module ClassMethods
      def with_item_keys(item_type, item_id)
        where :item_type => item_type, :item_id => item_id
      end

      def creates
        where :event => 'create'
      end

      def updates
        where :event => 'update'
      end

      def destroys
        where :event => 'destroy'
      end

      def not_creates
        where 'event <> ?', 'create'
      end

      # Expects `obj` to be an instance of `PaperTrail::Version` by default, but can accept a timestamp if
      # `timestamp_arg` receives `true`
      def subsequent(obj, timestamp_arg = false)
        if timestamp_arg != true && self.primary_key_is_int?
          return where(arel_table[primary_key].gt(obj.id)).order(arel_table[primary_key].asc)
        end

        obj = obj.send(PaperTrail.timestamp_field) if obj.is_a?(self)
        where(arel_table[PaperTrail.timestamp_field].gt(obj)).order(self.timestamp_sort_order)
      end

      def preceding(obj, timestamp_arg = false)
        if timestamp_arg != true && self.primary_key_is_int?
          return where(arel_table[primary_key].lt(obj.id)).order(arel_table[primary_key].desc)
        end

        obj = obj.send(PaperTrail.timestamp_field) if obj.is_a?(self)
        where(arel_table[PaperTrail.timestamp_field].lt(obj)).order(self.timestamp_sort_order('desc'))
      end


      def between(start_time, end_time)
        where(
          arel_table[PaperTrail.timestamp_field].gt(start_time).
          and(arel_table[PaperTrail.timestamp_field].lt(end_time))
        ).order(self.timestamp_sort_order)
      end

      # defaults to using the primary key as the secondary sort order if possible
      def timestamp_sort_order(direction = 'asc')
        [arel_table[PaperTrail.timestamp_field].send(direction.downcase)].tap do |array|
          array << arel_table[primary_key].send(direction.downcase) if self.primary_key_is_int?
        end
      end

      # Performs an attribute search on the serialized object by invoking the
      # identically-named method in the serializer being used.
      def where_object(args = {})
        raise ArgumentError, 'expected to receive a Hash' unless args.is_a?(Hash)
        arel_field = arel_table[:object]

        where_conditions = args.map do |field, value|
          PaperTrail.serializer.where_object_condition(arel_field, field, value)
        end.reduce do |condition1, condition2|
          condition1.and(condition2)
        end

        where(where_conditions)
      end

      def primary_key_is_int?
        @primary_key_is_int ||= columns_hash[primary_key].type == :integer
      rescue
        true
      end

      # Returns whether the `object` column is using the `json` type supported by PostgreSQL
      def object_col_is_json?
        @object_col_is_json ||= columns_hash['object'].type == :json
      end

      # Returns whether the `object_changes` column is using the `json` type supported by PostgreSQL
      def object_changes_col_is_json?
        @object_changes_col_is_json ||= columns_hash['object_changes'].type == :json
      end
    end

    # Restore the item from this version.
    #
    # This will automatically restore all :has_one associations as they were "at the time",
    # if they are also being versioned by PaperTrail.  NOTE: this isn't always guaranteed
    # to work so you can either change the lookback period (from the default 3 seconds) or
    # opt out.
    #
    # Options:
    # :has_one     set to `false` to opt out of has_one reification.
    #              set to a float to change the lookback time (check whether your db supports
    #              sub-second datetimes if you want them).
    def reify(options = {})
      return nil if object.nil?

      without_identity_map do
        options[:has_one] = 3 if options[:has_one] == true
        options.reverse_merge! :has_one => false

        attrs = self.class.object_col_is_json? ? object : PaperTrail.serializer.load(object)

        # Normally a polymorphic belongs_to relationship allows us
        # to get the object we belong to by calling, in this case,
        # `item`.  However this returns nil if `item` has been
        # destroyed, and we need to be able to retrieve destroyed
        # objects.
        #
        # In this situation we constantize the `item_type` to get hold of
        # the class...except when the stored object's attributes
        # include a `type` key.  If this is the case, the object
        # we belong to is using single table inheritance and the
        # `item_type` will be the base class, not the actual subclass.
        # If `type` is present but empty, the class is the base class.

        if item
          model = item
          # Look for attributes that exist in the model and not in this version. These attributes should be set to nil.
          (model.attribute_names - attrs.keys).each { |k| attrs[k] = nil }
        else
          inheritance_column_name = item_type.constantize.inheritance_column
          class_name = attrs[inheritance_column_name].blank? ? item_type : attrs[inheritance_column_name]
          klass = class_name.constantize
          model = klass.new
        end

        model.class.unserialize_attributes_for_paper_trail attrs

        # Set all the attributes in this version on the model
        attrs.each do |k, v|
          if model.has_attribute?(k)
            model[k.to_sym] = v
          elsif model.respond_to?("#{k}=")
            model.send("#{k}=", v)
          else
            logger.warn "Attribute #{k} does not exist on #{item_type} (Version id: #{id})."
          end
        end

        model.send "#{model.class.version_association_name}=", self

        unless options[:has_one] == false
          reify_has_ones model, options[:has_one]
        end

        model
      end
    end

    # Returns what changed in this version of the item.  Cf. `ActiveModel::Dirty#changes`.
    # Returns `nil` if your `versions` table does not have an `object_changes` text column.
    def changeset
      return nil unless self.class.column_names.include? 'object_changes'

      _changes = self.class.object_changes_col_is_json? ? object_changes : PaperTrail.serializer.load(object_changes)
      @changeset ||= HashWithIndifferentAccess.new(_changes).tap do |changes|
        item_type.constantize.unserialize_attribute_changes(changes)
      end
    rescue
      {}
    end

    # Returns who put the item into the state stored in this version.
    def paper_trail_originator
      @paper_trail_originator ||= previous.whodunnit rescue nil
    end

    def originator
      warn "DEPRECATED: use `paper_trail_originator` instead of `originator`. Support for `originator` will be removed in PaperTrail 4.0"
      self.paper_trail_originator
    end

    # Returns who changed the item from the state it had in this version.
    # This is an alias for `whodunnit`.
    def terminator
      @terminator ||= whodunnit
    end
    alias_method :version_author, :terminator

    def sibling_versions(reload = false)
      @sibling_versions = nil if reload == true
      @sibling_versions ||= self.class.with_item_keys(item_type, item_id)
    end

    def next
      @next ||= sibling_versions.subsequent(self).first
    end

    def previous
      @previous ||= sibling_versions.preceding(self).first
    end

    def index
      table = self.class.arel_table unless @index
      @index ||=
        if self.class.primary_key_is_int?
          sibling_versions.select(table[self.class.primary_key]).order(table[self.class.primary_key].asc).index(self)
        else
          sibling_versions.select([table[PaperTrail.timestamp_field], table[self.class.primary_key]]).
            order(self.class.timestamp_sort_order).index(self)
        end
    end

    private

    # In Rails 3.1+, calling reify on a previous version confuses the
    # IdentityMap, if enabled. This prevents insertion into the map.
    def without_identity_map(&block)
      if defined?(::ActiveRecord::IdentityMap) && ::ActiveRecord::IdentityMap.respond_to?(:without)
        ::ActiveRecord::IdentityMap.without(&block)
      else
        block.call
      end
    end

    # Restore the `model`'s has_one associations as they were when this version was
    # superseded by the next (because that's what the user was looking at when they
    # made the change).
    #
    # The `lookback` sets how many seconds before the model's change we go.
    def reify_has_ones(model, lookback)
      model.class.reflect_on_all_associations(:has_one).each do |assoc|
        child = model.send assoc.name
        if child.respond_to? :version_at
          # N.B. we use version of the child as it was `lookback` seconds before the parent was updated.
          # Ideally we want the version of the child as it was just before the parent was updated...
          # but until PaperTrail knows which updates are "together" (e.g. parent and child being
          # updated on the same form), it's impossible to tell when the overall update started;
          # and therefore impossible to know when "just before" was.
          if (child_as_it_was = child.version_at(send(PaperTrail.timestamp_field) - lookback.seconds))
            child_as_it_was.attributes.each do |k,v|
              model.send(assoc.name).send :write_attribute, k.to_sym, v rescue nil
            end
          else
            model.send "#{assoc.name}=", nil
          end
        end
      end
    end

    # checks to see if a value has been set for the `version_limit` config option, and if so enforces it
    def enforce_version_limit!
      return unless PaperTrail.config.version_limit.is_a? Numeric
      previous_versions = sibling_versions.not_creates
      return unless previous_versions.size > PaperTrail.config.version_limit
      excess_previous_versions = previous_versions - previous_versions.last(PaperTrail.config.version_limit)
      excess_previous_versions.map(&:destroy)
    end
  end
end
