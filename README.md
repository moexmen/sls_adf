[![Gem Version](https://badge.fury.io/rb/sls_adf.svg)](https://badge.fury.io/rb/sls_adf)
[![Build Status](https://travis-ci.org/moexmen/sls_adf.svg?branch=master)](https://travis-ci.org/moexmen/sls_adf)
[![Inline docs](http://inch-ci.org/github/moexmen/sls_adf.svg?branch=master)](http://inch-ci.org/github/moexmen/sls_adf)
[![Maintainability](https://api.codeclimate.com/v1/badges/5d7c2801d4a37ecf8cdf/maintainability)](https://codeclimate.com/github/moexmen/sls_adf/maintainability)

# SLS ADF - Ruby Client Library

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
(This can be placed in `config/initializers/` for Rails applications)

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

`sls_adf` provides ruby methods which can be used to make GraphQL calls to SLS ADF.
To use, follow the installation instructions above and configure the necessary details.

```ruby
# Queries
response = SlsAdf::Query.user('id')
response = SlsAdf::Query.context('uuid')
response = SlsAdf::Query.subject_group('uuid')
response = SlsAdf::Query.assignment('uuid')
response = SlsAdf::Query.task('uuid')

# Mutations
response = SlsAdf::Mutation.create_assignment(assignment_input)
response = SlsAdf::Mutation.update_assignment(uuid, assignment_input)
response = SlsAdf::Mutation.delete_assignment(uuid)
response = SlsAdf::Mutation.update_task(uuid, task_input)
response = SlsAdf::Mutation.create_notification(notification_input)
```

## Customization

`sls_adf` uses Github's [graphql-client](https://github.com/github/graphql-client) for
graphql functionality, and [Typhoeus](https://github.com/typhoeus/typhoeus) to make
http calls.

Two classes, `Adapter` (`SlsAdf::Util::Adapter`) and `Token` (`SlsAdf::Util::Token`) are
defined in this gem to support the most naive use case. These classes are designed to be
extended or replaced to support different use cases.

#### Customised GraphQL Calls

`sls_adf` provides pre-defined GraphQL calls to ADF. Should you require other calls,
you may:

1. Declare your custom GraphQL queries or mutations using the
   [graphql-client DSL](https://github.com/github/graphql-client#defining-queries),
   then execute them using `SlsAdf.query` with the appropriate variables.
2. For easy reuse, create a new class that inherits from `SlsAdf::Base` to wrap your custom
   queries, mutations or fragments.


## Development

Key Commands:
 - `bin/setup`: Install dependencies and copy `.env` file.
 - `bin/console`: Run an interactive prompt (requires configuration on .`env` file)
 - `rake spec` or `bundle exec rspec`: Run tests.

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/moexmen/sls_adf).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
