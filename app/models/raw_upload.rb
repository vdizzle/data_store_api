class RawUpload < ActiveRecord::Base
  attr_accessible :filename, :content, :size
end
