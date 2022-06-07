require 'bundler/setup'
Bundler::GemHelper.install_tasks

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test" << "lib"
  t.pattern = "test/**/*_test.rb"
end

task(default: :test)

desc "Vendor the latest GraphiQL version"
task :update_graphiql do
  require "fileutils"
  require "json"

  new_js_versions = {}
  new_css_versions = {}

  def replace_versions(manifest_file, new_versions)
    new_contents = new_versions.map{ |package, file| File.read(file) }.join("\n")
    File.write(manifest_file, new_contents)
  end

  def npm_version(package_json_path)
    npm_config = JSON.parse(File.read(package_json_path))
    npm_config["version"]
  end

  update_path = "./graphiql_update"

  old_assets = Dir["app/assets/**/{react,graphiql}-*.{js,css}"]
  puts "Removing #{old_assets.join(", ")}"
  FileUtils.rm(old_assets)

  FileUtils.mkdir_p(update_path)
  FileUtils.cd(update_path) do
    sh("npm init --force")
    sh("npm install graphiql react react-dom")

    FileUtils.cd("./node_modules/react") do
      new_version = npm_version("./package.json")
      new_js_versions["react"] = "app/assets/javascripts/graphiql/rails/react-#{new_version}.js"

      puts "Copying React #{new_version}"
      FileUtils.cp("./umd/react.production.min.js", ["../../../", new_js_versions["react"]].join)

    end

    FileUtils.cd("./node_modules/react-dom") do
      new_version = npm_version("./package.json")
      new_js_versions["react-dom"] = "app/assets/javascripts/graphiql/rails/react-dom-#{new_version}.js"

      puts "Copying ReactDOM #{new_version}"
      FileUtils.cp("./umd/react-dom.production.min.js", ["../../../", new_js_versions["react-dom"]].join)
    end

    new_js_versions["fetch"] = "app/assets/javascripts/graphiql/rails/fetch-0.10.1.js"

    FileUtils.cd("./node_modules/graphiql") do
      new_version = npm_version("./package.json")
      new_js_versions["graphiql"] = "app/assets/javascripts/graphiql/rails/graphiql-#{new_version}.js"
      new_css_versions["graphiql"] = "app/assets/stylesheets/graphiql/rails/graphiql-#{new_version}.css"

      puts "Copying GraphiQL #{new_version}"
      FileUtils.cp("./graphiql.js", ["../../../", new_js_versions["graphiql"]].join)
      FileUtils.cp("./graphiql.css", ["../../../", new_css_versions["graphiql"]].join)
    end

    new_js_versions["graphiql_show"] = "app/assets/javascripts/graphiql/rails/graphiql_show.js"
    new_css_versions["graphiql_show"] = "app/assets/stylesheets/graphiql/rails/graphiql_show.css"
  end

  js_manifest_path = "app/views/graphiql/rails/editors/_app_js.html.erb"
  css_manifest_path = "app/views/graphiql/rails/editors/_app_css.html.erb"
  puts "Updating manifests"
  replace_versions(js_manifest_path, new_js_versions)
  replace_versions(css_manifest_path, new_css_versions)
  # FileUtils.rm_rf(update_path)
end
