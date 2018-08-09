module Private
  module Deposits
    class DollarsController < ::Private::Deposits::BaseController
      include ::Deposits::CtrlBankable
    end
  end
end
