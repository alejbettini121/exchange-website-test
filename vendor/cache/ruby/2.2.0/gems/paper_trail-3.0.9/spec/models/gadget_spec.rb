require 'spec_helper'

describe Gadget do
  it { should be_versioned }

  let(:gadget) { Gadget.create!(:name => 'Wrench', :brand => 'Acme') }

  describe "updates", :versioning => true do
    it "should generate a version for updates to `name` attribute" do
      expect { gadget.update_attribute(:name, 'Hammer').to change{gadget.versions.size}.by(1) }
    end

    it "should ignore for updates to `brand` attribute" do
      expect { gadget.update_attribute(:brand, 'Stanley') }.to_not change{gadget.versions.size}
    end

    it "should still generate a version when only the `updated_at` attribute is updated" do
      expect { gadget.update_attribute(:updated_at, Time.now) }.to change{gadget.versions.size}.by(1)
    end
  end

  describe "Methods" do
    describe "Instance", :versioning => true do
      describe "private" do
        describe :changed_notably? do
          subject { Gadget.new(:created_at => Time.now) }

          # apparently the private methods list in Ruby18 is different than in Ruby19+
          if RUBY_VERSION.to_f >= 1.9
            its(:private_methods) { should include(:changed_notably?) }
          end

          context "create events" do
            it { subject.send(:changed_notably?).should == true }
          end

          context "update events" do
            before { subject.save! }

            context "without update timestamps" do
              it "should only acknowledge non-ignored attrs" do
                subject.name = 'Wrench'
                subject.send(:changed_notably?).should == true
              end

              it "should not acknowledge ignored attrs and timestamps only" do
                subject.brand = 'Acme'
                subject.send(:changed_notably?).should == false
              end
            end

            context "with update timestamps" do
              it "should only acknowledge non-ignored attrs" do
                subject.name, subject.updated_at = 'Wrench', Time.now
                subject.send(:changed_notably?).should == true
              end

              it "should not acknowledge ignored attrs and timestamps only" do
                subject.brand, subject.updated_at = 'Acme', Time.now
                subject.send(:changed_notably?).should == false
              end
            end
          end
        end
      end
    end
  end
end
