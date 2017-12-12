# SLS ADF - Ruby Client Library [![Build Status](https://travis-ci.org/moexmen/sls_adf.svg?branch=master)](https://travis-ci.org/moexmen/sls_adf)

Ruby support for GraphQL API calls to MOE's Student Learning Space.
This includes a few functionalities:
  - Token management
  - GraphQL Templates

Requires Ruby 2.4+.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sls_adf'
```

Configure the gem in the following manner:
(Can be placed in `config/initializers/` folder for Rails apps)

```ruby
SlsAdf.configure do |c|
  c.graphql_url = 'https://example.com'
  c.get_token_url = 'https://example.com/token'
  c.client_id = 'Foo'
  c.client_secret = 'Bar'
end
```

And then execute:

    $ bundle

## Usage
To be updated

## Customization
To be updated

## Development

After checking out the repo, run `bin/setup` to install dependencies.

To test, you can run `rake spec` or `bundle exec rspec`.

Run `bin/console` for an interactive prompt. You have to modify the
`.env` file to test the gem's functions.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/moexmen/adf_ruby).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
