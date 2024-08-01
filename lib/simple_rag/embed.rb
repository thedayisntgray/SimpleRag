module SimpleRag
  class Embed
    def self.embed_text(client, input)
      embeddings_batch_response = client.embeddings({model: "mistral-embed", input: input})
      embeddings_batch_response.dig("data", 0, "embedding")
    end

    def self.embed_chunks(client, chunks)
      text_embeddings = chunks.map { |chunk| embed_text(client, chunk) }
      Numo::DFloat[*text_embeddings]
    end
  end
end
