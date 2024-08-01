module SimpleRag
  class Generate
    def prompt(question, retrieved_chunks)
      prompt = <<~PROMPT
        Context information is below.
        ---------------------
        #{retrieved_chunks.join("\n---------------------\n")}
        ---------------------
        Given the context information and not prior knowledge, answer the query.
        Query: #{question}
        Answer:
      PROMPT
    end
  end
end
