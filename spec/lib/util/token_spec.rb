RSpec.describe SlsAdf::Util::Token do
  def expected_response_body
    JSON.dump(data: { token: SlsAdf::CLIENT_TOKEN })
  end

  def expected_request_body
    { 'clientId' => SlsAdf.configuration.client_id,
      'clientSecret' => SlsAdf.configuration.client_secret,
      'grantType' => 'client_credentials',
      'scope' => 'all' }
  end

  describe '.token' do
    let!(:stub) do
      stub_request(:post, SlsAdf.configuration.get_token_url).
        to_return(status: 200, body: expected_response_body)
    end
    subject { SlsAdf::Util::Token.token }

    it 'returns the correct token' do
      expect(subject).to eq SlsAdf::CLIENT_TOKEN
      expect(stub).to have_been_requested
    end

    context 'when token has been pre-loaded' do
      before { subject }
      it 'does not make another API call to load the token' do
        # Clears stub and request history
        WebMock.reset!
        # Subject is not used as it doesn't invoke the actual object's method again.
        SlsAdf::Util::Token.token
        expect(a_request(:any, SlsAdf.configuration.get_token_url)).
          not_to have_been_made
      end
    end
  end

  describe '.refresh_token' do
    let!(:stub) do
      stub_request(:post, SlsAdf.configuration.get_token_url).
        to_return(status: http_response_code, body: expected_response_body)
    end
    let(:http_response_code) { 200 }
    subject { SlsAdf::Util::Token.refresh_token }

    it 'returns the correct token' do
      expect(subject).to eq SlsAdf::CLIENT_TOKEN
      expect(stub).to have_been_requested
    end

    it 'makes the right API call to the get token url' do
      stub =
        stub_request(:post, SlsAdf.configuration.get_token_url).
          with(
            headers: { 'Content-Type' => 'application/json' },
            body: expected_request_body
          ).
          to_return(status: 200, body: expected_response_body)
      subject
      expect(stub).to have_been_requested
    end

    context 'when token has been preloaded' do
      before { subject }
      it 'makes another API call to load the token' do
        # Clears stub and request history
        WebMock.reset!

        new_stub = stub_request(:post, SlsAdf.configuration.get_token_url).
                     to_return(status: 200, body: expected_response_body)
        # Subject is not used as it doesn't invoke the actual object's method again.
        SlsAdf::Util::Token.refresh_token
        expect(new_stub).to have_been_requested
      end
    end

    context 'when API response is malformed' do
      let!(:stub) do
        stub_request(:post, SlsAdf.configuration.get_token_url).
          to_return(status: 200, body: '400 Error')
      end

      it 'returns an empty string as the token' do
        expect(subject).to eq('')
      end
    end

    context 'when API response does not have http status code 200' do
      let(:http_response_code) { 400 }
      it 'returns an empty string as the token' do
        expect(subject).to eq('')
      end
    end
  end
end
