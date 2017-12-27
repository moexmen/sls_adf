RSpec.describe SlsAdf::Util::Adapter do
  let(:adapter) { SlsAdf::Util::Adapter.new }
  describe '.execute' do
    let(:document) do
      GraphQL.parse(<<-'GRAPHQL')
        query getCharacter($id: ID!) {
          character(id: $id) {
            name
          }
        }
      GRAPHQL
    end
    let(:operation_name) { 'getCharacter' }
    let(:variables) { { 'id' => '1001' } }
    subject do
      adapter.execute(
        document: document, operation_name: operation_name, variables: variables
      )
    end

    context 'when response is successful' do
      let!(:stub) do
        stub_request(:post, SlsAdf.configuration.graphql_url).
          to_return(status: 200, body: JSON.dump(response))
      end
      let(:response) do
        { 'data' => { 'character' => { 'name' => 'Darth Vader' } } }
      end

      it { is_expected.to include(response) }
      it { is_expected.to include(http_status: 200) }
    end

    context 'when request is sent' do
      let!(:stub) do
        stub_request(:post, SlsAdf.configuration.graphql_url).
          with(headers: request_headers, body: JSON.dump(request_body)).
          to_return(status: 200, body: JSON.dump('data' => 'foo'))
      end
      let(:request_headers) do
        {
          'Accept' => 'application/json',
          'Content-Type' => 'application/json',
          'Authorization' => 'Bearer ' + SlsAdf::CLIENT_TOKEN
        }
      end
      let(:request_body) do
        {
          'query' => document.to_query_string,
          'operationName' => operation_name,
          'variables' => variables
        }
      end

      it 'constructs the correct request headers and body' do
        subject
        expect(stub).to have_been_requested
      end

      context 'when the first response is unauthorised' do
        let!(:stub) do
          stub_request(:post, SlsAdf.configuration.graphql_url).
            with(headers: request_headers, body: JSON.dump(request_body)).
            to_return(
              { status: 401, body: JSON.dump('errors' => 'wrong token') },
              { status: 200, body: JSON.dump('data' => 'correct') }
            )
        end

        it 'makes the same call after refreshing the token' do
          subject
          expect(stub).to have_been_requested.twice
        end
      end
    end

    context 'when the request times out' do
      let!(:stub) { stub_request(:post, SlsAdf.configuration.graphql_url).to_timeout }

      it 'returns an error response' do
        expect(subject).to have_key(:errors)
      end
    end

    context 'when the response is malformed' do
      let!(:stub) do
        stub_request(:post, SlsAdf.configuration.graphql_url).
          to_return(status: 200, body: 'wrong')
      end

      it 'returns an error response' do
        expect(subject).to have_key(:errors)
      end
    end
  end
end
