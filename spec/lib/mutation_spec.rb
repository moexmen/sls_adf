RSpec.describe SlsAdf::Mutation do
  let!(:stub) do
    stub_request(:post, SlsAdf.configuration.graphql_url).
      to_return(status: 200, body: JSON.dump('data' => response_hash))
  end
  let(:uuid) { SecureRandom.uuid }

  describe '.create_assignment' do
    let(:input) do
      {
        'title' => 'Foo',
        'start' => Time.now.iso8601,
        'end' => (Time.now + 10_000).iso8601,
        'createBy' => 'USERID-1',
        'type' => 'QUIZ',
        'subjectGroupUuid' => SecureRandom.uuid,
        'assignees' => ['USERID-2', 'USERID-3']
      }
    end
    let(:response_hash) { { 'subjectGroup' => {} } }
    subject { SlsAdf::Mutation.create_assignment(input) }

    it 'makes a http request' do
      subject
      expect(stub).to have_been_requested
    end
  end

  describe '.update_assignment' do
    let(:input) { { 'title' => 'Bar' } }
    let(:response_hash) { { 'subjectGroup' => {} } }
    subject { SlsAdf::Mutation.update_assignment(uuid, input) }

    it 'makes a http request' do
      subject
      expect(stub).to have_been_requested
    end
  end

  describe '.delete_assignment' do
    let(:response_hash) { { 'uuid' => {} } }
    subject { SlsAdf::Mutation.delete_assignment(uuid) }

    it 'makes a http request' do
      subject
      expect(stub).to have_been_requested
    end
  end

  describe '.update_task' do
    let(:uuid) { SecureRandom.uuid }
    let(:status) { 'COMPLETED' }
    let(:response_hash) { { 'task' => {} } }
    subject { SlsAdf::Mutation.update_task(uuid, status) }

    it 'makes a http request' do
      subject
      expect(stub).to have_been_requested
    end
  end

  describe '.create_notification' do
    let(:input) do
      {
        'message' => 'Test notification',
        'scope' => 'SUBJECT_GROUP',
        'scopeId' => SecureRandom.uuid,
        'eventType' => 'LAUNCH_APP',
        'eventTypeId' => SecureRandom.uuid,
        'receipient' => ['USERID-1', 'USERID-2']
      }
    end
    let(:response_hash) { { 'notification' => {} } }
    subject { SlsAdf::Mutation.create_notification(input) }

    it 'makes a http request' do
      subject
      expect(stub).to have_been_requested
    end
  end
end
