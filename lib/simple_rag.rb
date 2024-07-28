# frozen_string_literal: true

require "httparty"
require "numo/narray"
require "faiss"
require "matrix"
require "io/console"
require "mistral-ai"
require_relative "simple_rag/version"
require_relative "simple_rag/cli"

module SimpleRag
  class Error < StandardError; end

  class Runner
    def get_text_embedding(client, input)
      embeddings_batch_response = client.embeddings({model: "mistral-embed", input: input})
      embeddings_batch_response.dig("data", 0, "embedding")
    end

    def run_mistral(client, user_message, model: "mistral-medium-latest")
      messages = [{role: "user", content: user_message}]
      chat_response = client.chat_completions({model: model, messages: messages})
      chat_response.dig("choices", 0, "message", "content")  # .choices[0].message.content
    end

    def do_everything
      #Load
      response = HTTParty.get("https://raw.githubusercontent.com/run-llama/llama_index/main/docs/docs/examples/data/paul_graham/paul_graham_essay.txt")
      text = response.body

      File.write("essay.txt", text)

      text.length

      chunk_size = 2048
      chunks = text.chars.each_slice(chunk_size).map(&:join)

      chunks.length

      api_key = ENV["MISTRAL_KEY"] || ENV['MISTRAL_AI_KEY'] || STDIN.getpass("Type your API Key: ")

      client = Mistral.new(
        credentials: {api_key: api_key},
        options: {server_sent_events: true}
      )

      text_embeddings = chunks.map { |chunk| get_text_embedding(client, chunk) }

      text_embeddings = Numo::DFloat[*text_embeddings]

      d = text_embeddings.shape[1]
      index = Faiss::IndexFlatL2.new(d)
      index.add(text_embeddings)

      question = "What were the two main things the author worked on before college?"
      question_embedding = get_text_embedding(client, question)
      question_embeddings = Numo::DFloat[question_embedding]

      question_embeddings.shape

      distances, indices = index.search(question_embeddings, 2)
      index_array = indices.to_a[0]
      retrieved_chunks = index_array.map { |i| chunks[i] }

      prompt = <<~PROMPT
        Context information is below.
        ---------------------
        #{retrieved_chunks.join("\n---------------------\n")}
        ---------------------
        Given the context information and not prior knowledge, answer the query.
        Query: #{question}
        Answer:
      PROMPT

      puts run_mistral(client, prompt)
    end
  end
end
