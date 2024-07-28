module SimpleRag
  class Retrieve
    def get_text_embedding(client, input)
      embeddings_batch_response = client.embeddings({model: "mistral-embed", input: input})
      embeddings_batch_response.dig("data", 0, "embedding")
    end
  end
end
