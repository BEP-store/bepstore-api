shared_context 'serializer' do
  let(:serializer) do
    described_class.new(resource, scope: user)
  end

  subject do
    JSON.parse(serializer.to_json, symbolize_names: true)
  end
end
