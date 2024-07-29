module SimpleRag
  class Index
    def load(url)
      response = HTTParty.get(url)
      text = response.body
      File.write("data/essay.txt", text)
      text
    end

    def chunk(text)
      chunk_size = 2048
      chunks = text.chars.each_slice(chunk_size).map(&:join)
      chunks
    end

    def embed(client,chunks)
      text_embeddings = chunks.map { |chunk| SimpleRag::Retrieve.new.get_text_embedding(client, chunk) }

      text_embeddings = Numo::DFloat[*text_embeddings]

      d = text_embeddings.shape[1]
      index = Faiss::IndexFlatL2.new(d)
      index.add(text_embeddings)
      index
    end
  end
end
