module Private::Withdraws
  class BitcoingoldsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
