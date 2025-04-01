module GraphiQL
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace GraphiQL::Rails

      if defined?(Sprockets) && Sprockets::VERSION.chr.to_i >= 4
        initializer 'graphiql.assets.precompile' do |app|
          app.config.assets.precompile += ["graphiql/rails/application.css"]
        end
      elsif !defined?(Propshaft)
        initializer 'graphiql.assets.public' do |app|
          app.middleware.use(ActionDispatch::Static, "#{root}/public")
        end
      end
    end
  end
end
