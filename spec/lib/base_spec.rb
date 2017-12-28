RSpec.describe SlsAdf::Base do
  # Dummy class for testing SlsAdf::Base
  class DummyBase < SlsAdf::Base
    class << self
      def test_execute_query(template, variables = {})
        execute_query(template, variables)
      end
    end
  end

  # Modify schema to load from the GraphQL endpoint.
  module SlsAdf
    def self.schema
      @schema ||= GraphQL::Client.load_schema(adapter)
    end
  end

  describe '.execute_query' do
    subject { DummyBase.test_execute_query(template, variables) }
    let(:character_variables) { { 'id' => '1001' } }
    let(:starship_variables) { { 'id' => '3000' } }

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
