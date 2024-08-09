describe SimpleRag::Generate do
  let(:query) { "What kind of day is it?" }
  let(:retrieved_chunks) { ["this is a", "very good day"] }

  it "can be created" do
    generate = SimpleRag::Generate.new
    result = generate.prompt(query, retrieved_chunks)
    expect(result).to include(retrieved_chunks[0])
    expect(result).to include(retrieved_chunks[1])
    expect(result).to include(query)
  end
end
