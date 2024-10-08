Gem::Specification.new do |spec|
  spec.name = "simple_rag"
  spec.version = "0.1.3"
  spec.summary = "Simple Rag is a lightweight library that transforms any Ruby project into a simple RAG application."
  spec.authors = ["Landon Gray"]
  spec.email = ["landon.gray@hey.com"]
  spec.files = Dir["lib/**/*", "exe/*", "data/**"]
  spec.executables = ["simple_rag"]
  spec.bindir = "exe"
  spec.require_paths = ["lib"]
end
