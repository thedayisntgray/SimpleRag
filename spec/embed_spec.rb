RSpec.describe SimpleRag::Embed do
  let(:client) { double("client") }
  let(:embedding_response) { {"data" => [{"embedding" => [0.1, 0.2, 0.3]}]} }
  let(:chunks) { ["text chunk 1", "text chunk 2"] }
  let(:numo_array) { Numo::DFloat[[0.1, 0.2, 0.3], [0.1, 0.2, 0.3]] }
  let(:index) { instance_double(Faiss::IndexFlatL2) }

  before do
    allow(client).to receive(:embeddings).and_return(embedding_response)
    allow(Numo::DFloat).to receive(:[]).and_return(numo_array)
    allow(Faiss::IndexFlatL2).to receive(:new).and_return(index)
    allow(index).to receive(:add)
  end

  describe "#get_text_embedding" do
    it "returns the correct embedding from the client" do
      embed_instance = SimpleRag::Embed.new
      result = embed_instance.get_text_embedding(client, "some input")
      expect(result).to eq([0.1, 0.2, 0.3])
    end
  end

  describe "#embed" do
    it "returns a Faiss index with the correct embeddings" do
      embed_instance = SimpleRag::Embed.new
      result = embed_instance.embed(client, chunks)
      expect(result).to eq(index)
      expect(Numo::DFloat).to have_received(:[]).with([0.1, 0.2, 0.3], [0.1, 0.2, 0.3])
      expect(index).to have_received(:add).with(numo_array)
    end
  end
end
