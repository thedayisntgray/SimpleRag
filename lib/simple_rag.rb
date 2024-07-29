# frozen_string_literal: true

require "httparty"
require "numo/narray"
require "faiss"
require "matrix"
require "io/console"
require "mistral-ai"
require_relative "simple_rag/version"
require_relative "simple_rag/cli"
require "zeitwerk"
require 'dotenv/load'


loader = Zeitwerk::Loader.for_gem
loader.setup

module SimpleRag
  class Error < StandardError; end

  class Runner

    def run_mistral(client, user_message, model: "mistral-medium-latest")
      messages = [{role: "user", content: user_message}]
      chat_response = client.chat_completions({model: model, messages: messages})
      chat_response.dig("choices", 0, "message", "content")  # .choices[0].message.content
    end

    def init
      api_key = ENV["MISTRAL_AI_KEY"] || STDIN.getpass("Type your API Key: ")
      raise "Missing API Key" unless api_key


      client = Mistral.new(
        credentials: {api_key: api_key},
        options: {server_sent_events: true}
      )

      index_instance = SimpleRag::Index.new
      text = index_instance.load("https://raw.githubusercontent.com/run-llama/llama_index/main/docs/docs/examples/data/paul_graham/paul_graham_essay.txt")

      chunks  = index_instance.chunk(text)

      index = index_instance.embed(client,chunks)

      question = "What were the two main things the author worked on before college?"
      question_embedding = SimpleRag::Retrieve.new.get_text_embedding(client, question)
      question_embeddings = Numo::DFloat[question_embedding]

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
