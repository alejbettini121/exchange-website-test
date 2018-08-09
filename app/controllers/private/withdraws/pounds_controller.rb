module Private::Withdraws
  class PoundsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
