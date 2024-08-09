describe SimpleRag::Retrieve do
  it "can save chunks" do
    chunks = ["the world", "is blue", "and green"]
    client = double("client")
    subject = SimpleRag::Retrieve.new(client)
    subject.save_chunks(chunks)
    expect(subject.chunks).to eq(chunks)
  end
end
