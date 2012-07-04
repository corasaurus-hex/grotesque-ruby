# Grotesque

To understand this library you'll want to first have a look at the dictionary definition of [grotesque](http://dictionary.reference.com/browse/grotesque), then understand that this is bizarre, fantastically ugly, and absurd.

This library will provide tooling to use Apache ZooKeeper like Redis. It will provide a server which you can run alongside your ZooKeeper instances that will provide an API to clients. Via this API you will be able to perform atomic modifications to data structures stored in ZooKeeper. I may even provide a server-less version, who knows.

The goal here is to provide many of the data structures that Redis provides but in an extremely fault-tolerant way. This may be far too slow for some purposes, but I guess we'll see. I plan to port the server to golang if I can make it work well enough.

This may be my worst idea yet.

## Installation

Add this line to your application's Gemfile:

    gem 'grotesque'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grotesque

## Usage

Don't use this yet, but see the specs for how you might use it in the future if it works out at all.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes with specs (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
