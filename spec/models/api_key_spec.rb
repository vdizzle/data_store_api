require 'spec_helper'

describe ApiKey do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:key) }
  it { should_not allow_mass_assignment_of(:key) }
  xit { should have_db_index(:key).unique(true) }

  context 'with an existing API key' do
    before { ApiKey.create(name: 'api_user') }
    it { should validate_uniqueness_of(:key) }
  end
end
