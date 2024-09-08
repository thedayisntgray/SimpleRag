# SimpleRag

<img src="https://github.com/user-attachments/assets/038b46f5-7064-4c68-a69c-6de1c886b687" alt="Screenshot" width="400"/>



[Simple Rag](https://rubygems.org/gems/simple_rag) is a lightweight library that showcases the entire RAG architecture in a gem. No need for a vector database. All you need are a few light dependencies and a Mistral API key!

The purpose of simple RAG is to showcase how RAG systems work by using the simplest tools possible to lower the friction to learning. This is not a gem to be used in production and I will likely be adding additional breaking changes to the code.

## Wait what...can you explain how it works?

Sure, here is a high level run through of the RAG architecture:

[simple_rag walkthrough](https://vimeo.com/994746572)


## Installation

Install the gem and add to the application's Gemfile by executing:

```sh
bundle add simple_rag
```

If bundler is not being used to manage dependencies, install the gem by executing:

```sh
gem install simple_rag
```

You will also need to install all dependencies required by the [faiss gem](https://github.com/ankane/faiss-ruby?tab=readme-ov-file#installation) under the installation section.

Lastly, run the following command and add a `mistral-ai`. You can create one my setting up a [Mistral AI account](https://docs.mistral.ai/getting-started/quickstart/#account-setup).

## Usage

To run the exe locally type:

```sh
exe/simple_rag
```

You can press enter when prompted to retrieve a default text. You can also search [project gutenberg](https://www.gutenberg.org/) for an html text like [Frankenstein](https://www.gutenberg.org/cache/epub/42324/pg42324.txt) by Mary Shelly.
This process of fetching text given a url could take some time as the text, once fetched get's passed to an embedding model which converts text chunks into vectors.



https://github.com/user-attachments/assets/1772ccce-95fd-4876-aa5b-7743b34bfce4

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Inspirations and Acknowledgements

This code was inspired by mistral's guide on [Basic Rag](https://docs.mistral.ai/guides/rag/)

[Andrei](https://x.com/rushing_andrei) for making me excited about vector search with his [talks on langchain.rb](https://www.youtube.com/watch?v=VMW8FyvI9hg)!

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/thedayisntgray/simple_rag.
