module SimpleRag
  class Index
    def initialize(client)
      @text = nil
      @client = client
    end

    def load(url)
      response = HTTParty.get(url)
      text = response.body

      File.write(get_absolute_path, text)
      @text = text
      text
    end

    def chunk(text)
      chunk_size = 2048
      text.chars.each_slice(chunk_size).map(&:join)
    end

    def embed_chunks(chunks)
      SimpleRag::Embed.embed_chunks(@client, chunks)
    end

    def save(text_embeddings)
      d = text_embeddings.shape[1]
      index = Faiss::IndexFlatL2.new(d)
      index.add(text_embeddings)
      index
    end

    #TODO: Strip out this hack.
    def get_absolute_path
      File.expand_path('../../../data/essay.txt', __FILE__)
    end
  end
end
