module SimpleRag
  class CLI
    def self.start(args)
      puts "Hello from SimpleRag!"
      # Your code here
      SimpleRag::Runner.new.do_everything
    end
  end
end
