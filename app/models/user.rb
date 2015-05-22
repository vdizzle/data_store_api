class User < ActiveRecord::Base
  include BCrypt

  attr_accessible :email
  validates :email, presence: true

  def password
    @password ||= Password.new(self.encrypted_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.encrypted_password = @password
  end

  def authenticate(attempted_password)
    if self.password == attempted_password
      true
    else
      false
    end
  end
end
