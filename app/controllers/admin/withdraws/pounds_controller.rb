module Admin
  module Withdraws
    class PoundsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Pound'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_pounds = @pounds.with_aasm_state(:accepted).order("id DESC")
        @all_pounds = @pounds.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        if @pound.may_process?
          @pound.process!
        elsif @pound.may_succeed?
          @pound.succeed!
        end

        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @pound.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
