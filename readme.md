# GraphiQL-Rails [![Gem Version](https://badge.fury.io/rb/graphiql-rails.svg)](https://badge.fury.io/rb/graphiql-rails) [![Build Status](https://travis-ci.org/rmosolgo/graphiql-rails.svg)](https://travis-ci.org/rmosolgo/graphiql-rails)

Mount the [GraphiQL IDE](https://github.com/graphql/graphiql) in Ruby on Rails.

![image](https://cloud.githubusercontent.com/assets/2231765/12101544/4779ed54-b303-11e5-918e-9f3d3e283170.png)

## Installation

Add to your Gemfile:

```ruby
gem "graphiql-rails"
```

## Usage

### Mount the Engine

Add the engine to `routes.rb`:

```ruby
# config/routes.rb
Rails.application.routes.draw do
  # ...
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/your/endpoint"
  end
end
```

- `at:` is the path where GraphiQL will be served. You can access GraphiQL by visiting that path in your app.
- `graphql_path:` is the path to the GraphQL endpoint. GraphiQL will send queries to this path.

### Configuration

You can override `GraphiQL::Rails` configs in an initializer (eg, `config/initializers/graphiql.rb`). The configs are:

```ruby
# These are the default values:
GraphiQL::Rails.config.query_params = false # if true, the GraphQL query string will be persisted the page's query params.
GraphiQL::Rails.config.initial_query = GraphiQL::Rails::WELCOME_MESSAGE # This string is presented to a new user
GraphiQL::Rails.config.csrf = false # if true, CSRF token will added and sent along with POST request to the GraphQL endpoint
```

### Development

- Tests: `rake test`
- Update GraphiQL & dependencies: `rake update_graphiql`
