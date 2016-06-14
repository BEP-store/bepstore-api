shared_examples_for 'ActivitySerializer' do
  let(:user) { resource.user }
  include_context 'serializer'

  its([:id]) { should eq(resource.id.to_s) }
end
