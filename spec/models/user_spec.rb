require 'spec_helper'

describe User do
  describe 'Validate email presence' do
    subject do
      user = User.new
      user.password = 'pass'
      user
    end
    it { should validate_presence_of(:email) }
  end

  it { should validate_presence_of(:encrypted_password) }
  it { should allow_mass_assignment_of(:email) }
  xit { should have_db_index(:email).unique(true) }
end
