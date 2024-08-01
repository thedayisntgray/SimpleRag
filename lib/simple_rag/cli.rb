module SimpleRag
  class CLI
    def self.start(args)
      puts "Hello from SimpleRag!"
      SimpleRag::Engine.new.run
    end
  end
end
