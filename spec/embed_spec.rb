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

  describe "#embed_text" do
    it "returns the correct embedding from the client" do
      embed_instance = SimpleRag::Embed
      result = embed_instance.embed_text(client, "some input")
      expect(result).to eq([0.1, 0.2, 0.3])
    end
  end

  describe "#embed_chunks" do
    it "returns a Faiss index with the correct embeddings" do
      embed_instance = SimpleRag::Embed
      result = embed_instance.embed_chunks(client, chunks)
      expect(result).to be_a(Numo::DFloat)
    end
  end
end
