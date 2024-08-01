RSpec.describe SimpleRag::Index do
  describe "#load" do
    let(:url) { "http://example.com" }
    let(:response_body) { "This is a sample text from the URL." }
    let(:response) { double("HTTParty::Response", body: response_body) }
    let(:file_path) { "data/essay.txt" }

    before do
      allow(HTTParty).to receive(:get).with(url).and_return(response)
      allow(File).to receive(:write)
    end

    it "fetches the text from the URL and writes it to a file" do
      index = SimpleRag::Index.new
      result = index.load(url)

      expect(HTTParty).to have_received(:get).with(url)
      expect(File).to have_received(:write).with(file_path, response_body)
      expect(result).to eq(response_body)
    end
  end
end
