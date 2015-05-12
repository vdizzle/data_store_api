# == Schema Information
#
# Table nane: api_keys
# id                    :integer         not null primary key
# name                  :string          not null
# key                   :string          not null
# created_at            :datetime
# updated_at            :datetime

require 'securerandom'

class ApiKey < ActiveRecord::Base
  validates :name, presence: true
  validates :key, presence: true, :uniqueness => true
  attr_protected :key

  after_initialize { self.key ||= SecureRandom.uuid }
end
