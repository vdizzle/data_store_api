require 'spec_helper'

describe RawUpload do
  it { should allow_mass_assignment_of(:filename) }
  it { should allow_mass_assignment_of(:filetype) }
  it { should allow_mass_assignment_of(:content) }
  it { should allow_mass_assignment_of(:size) }
  it { should allow_mass_assignment_of(:line_count) }
  it { should_not allow_mass_assignment_of(:table_name) }
  it { should_not allow_mass_assignment_of(:meta_info) }

  it { should validate_presence_of(:filename) }
  it { should validate_presence_of(:filetype) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:line_count) }
  it { should validate_presence_of(:size) }
  it { should validate_numericality_of(:line_count).only_integer }
  it { should validate_numericality_of(:size).only_integer }

  describe '#before_validation' do
    it 'should upcase filetype' do
      upload = create(:raw_upload, filetype: 'csv')
      expect(upload.filetype).to eq('CSV')
    end
  end

  describe '#sample' do
    it 'should return an array of array for each csv row' do
      raw_upload = create(:raw_upload)
      sample = raw_upload.sample
      expect(sample[0]).to eq({ 'name' => 'Winston Churchill', 'email' => 'wc@gmail.com', 'address' => 'awesome' })
      expect(sample[1]).to eq({ 'name' => 'Adolf Hitler', 'email' => 'ah@gmail.com', 'address' => 'hell' })
    end
  end
end
