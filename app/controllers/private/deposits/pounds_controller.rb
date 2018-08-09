module Private
  module Deposits
    class PoundsController < ::Private::Deposits::BaseController
      include ::Deposits::CtrlBankable
    end
  end
end
