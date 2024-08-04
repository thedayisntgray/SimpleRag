module SimpleRag
  class Generate
    def prompt(query, retrieved_chunks)
      prompt = <<~PROMPT
        Context information is below.
        ---------------------
        #{retrieved_chunks.join("\n---------------------\n")}
        ---------------------
        Given the context information and not prior knowledge, answer the query.
        Query: #{query}
        Answer:
      PROMPT
    end
  end
end
