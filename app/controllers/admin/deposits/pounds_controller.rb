module Admin
  module Deposits
    class PoundsController < ::Admin::Deposits::BaseController
      load_and_authorize_resource :class => '::Deposits::Pound'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24)
        @pounds = @pounds.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC')

        @available_pounds = @pounds.includes(:member).
          with_aasm_state(:submitting, :warning, :submitted).
          order('id DESC')

        @available_pounds -= @pounds
      end

      def show
        flash.now[:notice] = t('.notice') if @pound.aasm_state.accepted?
      end

      def update
        if target_params[:txid].blank?
          flash[:alert] = t('.blank_txid')
          redirect_to :back and return
        end

        @pound.charge!(target_params[:txid])

        redirect_to :back
      end

      private
      def target_params
        params.require(:deposits_pound).permit(:sn, :holder, :amount, :created_at, :txid)
      end
    end
  end
end
