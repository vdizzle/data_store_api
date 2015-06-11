shared_context 'valid_api_user' do
  let(:api_client) { ApiKey.create(name: 'My Api Client') }

  let(:api_user) do
    user = User.new
    user.email = 'user@domain.com'
    user.password = 'password'
    user.save!
    user
  end
end
