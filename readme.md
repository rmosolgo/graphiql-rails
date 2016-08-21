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

You can override `GraphiQL::Rails.config` values in an initializer (eg, `config/initializers/graphiql.rb`). The configs are:

- `query_params` (boolean, default `false`): if `true`, the GraphQL query string will be persisted the page's query params
- `initial_query` (string, default `nil`): if provided, it will be rendered in the query pane for a visitor's first visit
- `csrf` (boolean, default `true`): include `X-CSRF-Token` in GraphiQL's HTTP requests
- `headers` (hash, `String => Proc`): procs to fetch header values for GraphiQL's HTTP requests, in the form `(view_context) -> { ... }`. For example:


    ```ruby
    GraphiQL::Rails.config.headers['Authorization'] = -> (context) { "bearer #{context.cookies['_graphql_token']}" }
    ```

### Development

- Tests: `rake test`
- Update GraphiQL & dependencies: `rake update_graphiql`
