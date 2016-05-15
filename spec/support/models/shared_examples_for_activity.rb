shared_examples_for 'Activity' do
  it { should respond_to(:engine) }

  it { should respond_to(:name) } unless described_class == Activity

  it { should validate_presence_of(:engine) }

  it { should be_valid }
end
