const path = require('path');
const webpack = require('webpack');

new webpack.DefinePlugin({
  'process.env.NODE_ENV': '"PRODUCTION"',
});

module.exports = {
  entry: './javascript/application.js',
  mode: "production",
  output: {
    filename: 'application.js',
    path: path.resolve(__dirname, 'app/assets/javascripts/graphiql/rails'),
    chunkFormat: false,
  },
  devtool: false
};
