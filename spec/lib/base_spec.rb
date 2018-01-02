RSpec.describe SlsAdf::Base do
  # Dummy class for testing SlsAdf::Base
  class DummyBase < SlsAdf::Base
    class << self
      def test_execute_query(template, variables = {})
        execute_query(template, variables)
      end
    end
  end

  module SlsAdf
    # Set SlsAdf.client to point to configuration url, and load schema from there
    def self.set_configration_sls_adf_client!
      def self.client
        @new_client ||= begin
          new_schema = GraphQL::Client.load_schema(adapter)
          GraphQL::Client.new(schema: new_schema, execute: adapter)
        end
      end
    end

    # Resets SlsAdf.client to the default
    def self.reset_sls_adf_client!
      def self.client
        @client ||= GraphQL::Client.new(schema: schema, execute: adapter)
      end
    end
  end

  describe '.execute_query' do
    subject { DummyBase.test_execute_query(template, variables) }
    let(:character_variables) { { 'id' => '1001' } }
    let(:starship_variables) { { 'id' => '3000' } }
    before { SlsAdf.set_configration_sls_adf_client! }
    after { SlsAdf.reset_sls_adf_client! }

    it 'returns the correct response' do
      WebMock.allow_net_connect!

      GetCharacter = SlsAdf.client.parse <<~'GRAPHQL'
        query ($id: ID!) {
          character(id: $id) {
            name
          }
        }
      GRAPHQL

      GetStarship = SlsAdf.client.parse <<~'GRAPHQL'
        query($id: ID!) {
          starship(id: $id) {
            name
            length
          }
        }
      GRAPHQL

      character_response = DummyBase.test_execute_query(GetCharacter, character_variables)
      expect(character_response.data.to_h).to include('character' => hash_including('name' => 'Darth Vader'))

      starship_response = DummyBase.test_execute_query(GetStarship, starship_variables)
      expect(starship_response.data.to_h).to eq('starship' => { 'name' => 'Millenium Falcon', 'length' => 34.37 })

      WebMock.disable_net_connect!
    end
  end
end
