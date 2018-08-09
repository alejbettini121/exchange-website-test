module Admin
  module Withdraws
    class BitcoingoldsController < ::Admin::Withdraws::BaseController
      load_and_authorize_resource :class => '::Withdraws::Bitcoingold'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @one_bitcoingolds = @bitcoingolds.with_aasm_state(:accepted).order("id DESC")
        @all_bitcoingolds = @bitcoingolds.without_aasm_state(:accepted).where('created_at > ?', start_at).order("id DESC")
      end

      def show
      end

      def update
        @bitcoingold.process!
        redirect_to :back, notice: t('.notice')
      end

      def destroy
        @bitcoingold.reject!
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
