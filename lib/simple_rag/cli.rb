module SimpleRag
  class CLI
    def self.start(args)
      puts "Hello from SimpleRag!"
      # Your code here
      SimpleRag::Runner.new.init
    end
  end
end
