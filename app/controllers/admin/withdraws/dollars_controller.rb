module Admin
  module Withdraws
    class DollarsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Dollar'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_dollars = @dollars.with_aasm_state(:accepted).order("id DESC")
        @all_dollars = @dollars.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        if @dollar.may_process?
          @dollar.process!
        elsif @dollar.may_succeed?
          @dollar.succeed!
        end

        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @dollar.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
