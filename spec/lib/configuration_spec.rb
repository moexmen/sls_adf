RSpec.describe SlsAdf::Configuration do
  subject { SlsAdf.configuration }

  it 'has a configuration object' do
    expect(subject).not_to be nil
  end

  describe 'sls_adf_helper file' do
    it 'initialises the paramters' do
      expect(subject.graphql_url).not_to be_nil
      expect(subject.get_token_url).not_to be_nil
      expect(subject.client_id).not_to be_nil
      expect(subject.client_secret).not_to be_nil
    end
  end

  describe 'when editing parameters' do
    let(:new_graphql_url) { 'new_url.com' }
    let(:new_token_url) { 'new_url.com/token' }
    let(:new_client_id) { 'new_client_id' }
    let(:new_client_secret) { 'new_client_secret' }

    before do
      SlsAdf.configure do |config|
        config.graphql_url = new_graphql_url
        config.get_token_url = new_token_url
        config.client_id = new_client_id
        config.client_secret = new_client_secret
      end
    end
    after { SlsAdf.initialise_sls_adf_gem! }

    it 'changes the parameters when accessed again' do
      expect(subject.graphql_url).to eq new_graphql_url
      expect(subject.get_token_url).to eq new_token_url
      expect(subject.client_id).to eq new_client_id
      expect(subject.client_secret).to eq new_client_secret
    end
  end
end
