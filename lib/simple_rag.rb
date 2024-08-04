# frozen_string_literal: true

require "httparty"
require "numo/narray"
require "faiss"
require "matrix"
require "io/console"
require "mistral-ai"
require "zeitwerk"
require "dotenv/load"
require "byebug"
require_relative "simple_rag/version"
require_relative "simple_rag/cli"

loader = Zeitwerk::Loader.for_gem
loader.setup

module SimpleRag
  class Error < StandardError; end

  class Engine

    DEFAULT_URL = "https://raw.githubusercontent.com/run-llama/llama_index/main/docs/docs/examples/data/paul_graham/paul_graham_essay.txt"

    def run_mistral(client, user_message, model: "mistral-medium-latest")
      messages = [{role: "user", content: user_message}]
      chat_response = client.chat_completions({model: model, messages: messages})
      chat_response.dig("choices", 0, "message", "content")
    end

    #url validator method
    def prompt_user_for_url
      print "Specify a URL to an HTML document you would like to ask questions of (Default: What I Worked On by Paul Graham): "
      input_url = gets.chomp
      input_url.empty? ? DEFAULT_URL : input_url
    end

    def valid_url?(url)
      uri = URI.parse(url)
      uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
    rescue URI::InvalidURIError
      false
    end

    def get_url
      url = prompt_user_for_url
      until valid_url?(url)
        puts "The URL provided is invalid. Please try again."
        url = prompt_user_for_url
      end
      url
    end

    def run
      url = get_url
      puts "Document Downloaded"

      # Setup LLM of choice
      api_key = ENV["MISTRAL_AI_KEY"] || STDIN.getpass("Type your API Key: ")
      raise "Missing API Key" unless api_key

      client = Mistral.new(
        credentials: {api_key: api_key},
        options: {server_sent_events: true}
      )

      # Indexing
      puts "Initialize indexing"
      index_instance = SimpleRag::Index.new(client)
      puts "Loading url"
      text = index_instance.load(url)
      puts "Chunk text" 
      chunks = index_instance.chunk(text)
      puts "Embed chunks" 
      text_embeddings = index_instance.embed_chunks(chunks)
      index = index_instance.save(text_embeddings)

      retrieve_instance = SimpleRag::Retrieve.new(client)
      retrieve_instance.save_index(index)
      retrieve_instance.save_chunks(chunks)

      loop do
        print "Enter your query (or type 'exit' to quit): "
        query = gets.chomp
        break if query.downcase == 'exit'
        puts

        # Retrieval/Search
        question_embedding = retrieve_instance.embed_query(query)
        retrieved_chunks = retrieve_instance.similarity_search(question_embedding, 2)

        # Generation
        prompt = SimpleRag::Generate.new.prompt(query, retrieved_chunks)

        puts run_mistral(client, prompt)
        puts
      end
    end
  end
end
