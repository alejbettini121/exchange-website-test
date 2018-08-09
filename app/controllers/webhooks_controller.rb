class WebhooksController < ApplicationController
	before_action :auth_anybody!
	skip_before_filter :verify_authenticity_token
	def tx
		if ( params[:type] == "transaction" ||params[:type] == "transfer" ) && params[:hash].present?
			AMQPQueue.enqueue(:deposit_coin, txid: params[:hash], channel_key: "satoshi")
			render :json => { :status => "queued" }
		else
			render :json => { :status => "not_queued" }
		end
	end
	def eth
		if ( params[:type] == "transaction" ||params[:type] == "transfer" ) && params[:hash].present?
			AMQPQueue.enqueue(:deposit_coin, txid: params[:hash], channel_key: "ether")
			render :json => { :status => "queued" }
		else
			render :json => { :status => "not_queued" }
		end
	end
	def xrp
		if ( params[:type] == "transaction" ||params[:type] == "transfer" ) && params[:hash].present?
			AMQPQueue.enqueue(:deposit_coin, txid: params[:hash], channel_key: "ripple")
			render :json => { :status => "queued" }
		else
			render :json => { :status => "not_queued" }
		end
	end
	def bch
		if ( params[:type] == "transaction" ||params[:type] == "transfer" ) && params[:hash].present?
			AMQPQueue.enqueue(:deposit_coin, txid: params[:hash], channel_key: "bitcoincash")
			render :json => { :status => "queued" }
		else
			render :json => { :status => "not_queued" }
		end
	end
	def btg
		if ( params[:type] == "transaction" ||params[:type] == "transfer" ) && params[:hash].present?
			AMQPQueue.enqueue(:deposit_coin, txid: params[:hash], channel_key: "bitcoingold")
			render :json => { :status => "queued" }
		else
			render :json => { :status => "not_queued" }
		end
	end
	def ltc
		if ( params[:type] == "transaction" ||params[:type] == "transfer" ) && params[:hash].present?
			AMQPQueue.enqueue(:deposit_coin, txid: params[:hash], channel_key: "litecoin")
			render :json => { :status => "queued" }
		else
			render :json => { :status => "not_queued" }
		end
	end
end
