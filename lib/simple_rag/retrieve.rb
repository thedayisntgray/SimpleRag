module SimpleRag
  class Retrieve
    def initialize(client)
      @client = client
      @query = nil
      @chunks = nil
      @index = nil
    end

    def query(query)
      @query = query
      query
    end

    def save_chunks(chunks)
      @chunks = chunks
    end

    def save_index(index)
      @index = index
    end

    def embed_query
      query_embedding = SimpleRag::Embed.embed_text(@client, @query)
      question_embeddings = Numo::DFloat[query_embedding]
    end

    def similarity_search(question_embeddings, k_neighbors_count)
      distances, indices = @index.search(question_embeddings, k_neighbors_count)
      index_array = indices.to_a[0]
      index_array.map { |i| @chunks[i] }
    end
  end
end
