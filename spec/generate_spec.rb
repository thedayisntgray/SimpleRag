describe SimpleRag::Generate do
  let(:query) { double("client") }
  let(:retrieved_chunks) { ['this is a', 'very good day'] }

  it "can be created" do
    generate = SimpleRag::Generate.new
    result = generate.prompt(query, retrieved_chunks)
    expect(result).to include(retrieved_chunks[0])
    expect(result).to include(retrieved_chunks[1])
  end
end
