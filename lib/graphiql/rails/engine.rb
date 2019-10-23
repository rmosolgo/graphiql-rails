module GraphiQL
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace GraphiQL::Rails

      if defined?(Sprockets) && Sprockets::VERSION.chr.to_i >= 4
        initializer 'graphiql.assets.precompile' do |app|
          app.config.assets.precompile += %w(
            graphiql/rails/application.css
            graphiql/rails/application.js
          )
        end
      end
    end
  end
end
