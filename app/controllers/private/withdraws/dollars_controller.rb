module Private::Withdraws
  class DollarsController < ::Private::Withdraws::BaseController
    include ::Withdraws::Withdrawable
  end
end
