module SimpleRag
  class LLM
    def initialize(client, user_message, model)
      @client = client || Mistral.new(
        credentials: {api_key: api_key},
        options: {server_sent_events: true}
      )
      @model = model || "mistral-medium-latest" 
    end
  end
end