module SimpleRag
  class Index
    def initialize(client)
      @text = nil
      @client = client
    end

    def load(url)
      response = HTTParty.get(url)
      text = response.body
      File.write(corrected_file_path, text)
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

    private
    def corrected_file_path
      #Todo: Fix this terrible hack.
      # Get the absolute path to the 'data' directory within the gem
      data_dir = File.expand_path('../../../data', __FILE__)
      file_path = File.join(data_dir, 'essay.txt')
    end
  end
end
