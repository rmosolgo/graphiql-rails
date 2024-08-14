GraphiQL::Rails::Engine.routes.draw do
  get "/", to: "editors#show"
end
