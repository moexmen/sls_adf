RSpec.describe SlsAdf::Query do
  let!(:stub) do
    stub_request(:post, SlsAdf.configuration.graphql_url).
      to_return(status: 200, body: JSON.dump('data' => response_hash))
  end

  describe '.context' do
    let(:uuid) { SecureRandom.uuid }
    let(:response_hash) { { 'context' => {} } }
    subject { SlsAdf::Query.context(uuid) }

    it 'makes a http request' do
      subject
      expect(stub).to have_been_requested
    end
  end

  describe '.user' do
    let(:id) { 'random-id' }
    let(:response_hash) { { 'user' => {} } }
    subject { SlsAdf::Query.user(id) }

    it 'makes a http request' do
      subject
      expect(stub).to have_been_requested
    end
  end

  describe '.subject_group' do
    let(:uuid) { SecureRandom.uuid }
    let(:response_hash) { { 'subjectGroup' => {} } }
    subject { SlsAdf::Query.subject_group(uuid) }

    it 'makes a http request' do
      subject
      expect(stub).to have_been_requested
    end
  end

  describe '.assignment' do
    let(:uuid) { SecureRandom.uuid }
    let(:response_hash) { { 'assignment' => {} } }
    subject { SlsAdf::Query.subject_group(uuid) }

    it 'makes a http request' do
      subject
      expect(stub).to have_been_requested
    end
  end

  describe '.task' do
    let(:uuid) { SecureRandom.uuid }
    let(:response_hash) { { 'task' => {} } }
    subject { SlsAdf::Query.subject_group(uuid) }

    it 'makes a http request' do
      subject
      expect(stub).to have_been_requested
    end
  end
end
