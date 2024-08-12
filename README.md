# SimpleRag

Simple Rag is a lightweight library that showcases the entire RAG architecture in a gem.

The purpose of simple RAG is to showcase how RAG systems work by using the simplest tools possible to lower the friction to learning. This is not a gem to be used in production and I will likely be adding additional breaking changes to the code.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add simple_rag

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install simple_rag

You will also need to install all dependencies required by the [faiss gem](https://github.com/ankane/faiss-ruby?tab=readme-ov-file#installation)

Lastly, run the following command and add a mistal-ai. You can create one my setting up a [Mistal AI account](https://docs.mistral.ai/getting-started/quickstart/#account-setup).

## Usage

To run the exe locally type:

exe/simple_rag

You can press enter when prompted to retrieve a default text. You can also search [project gutenberg](https://www.gutenberg.org/) for an html text like [Frankenstein](https://www.gutenberg.org/cache/epub/42324/pg42324.txt) by Mary Shelly.
This process of fetching text given a url could take some time as the text, once fetched get's passed to an embedding model which converts text chuncks into vectors.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/simple_rag.
