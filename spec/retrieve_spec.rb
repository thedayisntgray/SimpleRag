describe SimpleRag::Retrieve do
  describe "#get_text_embedding" do
    let(:client) { double("Client") }
    let(:input) { "sample text" }
    let(:response) { {"data" => [{"embedding" => [0.1, 0.2, 0.3]}]} }

    before do
      allow(client).to receive(:embeddings).with(hash_including(model: "mistral-embed", input: input)).and_return(response)
    end

    it "returns the embedding from the client response" do
      embedding = SimpleRag::Embed.new
      result = embedding.get_text_embedding(client, input)
      expect(result).to eq([0.1, 0.2, 0.3])
    end
  end
end
