require 'warden'

Warden::Strategies.add(:password) do
  def valid?
    params[:user][:username] && params[:user][:password]
  end

  def authenticate!
    json_params = JSON.parse(request.body.read).deep_symbolize_keys rescue {}
    user = User.where(email: json_params[:user][:username]).last

    if user.nil?
      throw(:warden, message: 'The username you entered does not exist.')
    elsif user.authenticate(json_params[:user][:password])
      success!(user)
    else
      throw(:warden, message: 'The username and password combination is invalid.')
    end
  end
end
