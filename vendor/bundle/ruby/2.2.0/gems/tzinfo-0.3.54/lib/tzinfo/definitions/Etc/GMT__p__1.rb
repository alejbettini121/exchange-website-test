# encoding: UTF-8

module TZInfo
  module Definitions
    module Etc
      module GMT__p__1
        include TimezoneDefinition
        
        timezone 'Etc/GMT+1' do |tz|
          tz.offset :o0, -3600, 0, :'-01'
          
        end
      end
    end
  end
end
