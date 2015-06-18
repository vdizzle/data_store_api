require 'lib/data_types'

module Routes
  class V1::MetaInfo < V1::Base
    get '/meta-info/data-types' do
      json DataTypes.all
    end
  end
end
