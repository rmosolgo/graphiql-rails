const path = require('path');

module.exports = {
  entry: './javascript/application.js',
  mode: "production",
  output: {
    filename: 'application.js',
    path: path.resolve(__dirname, 'app/assets/javascripts/graphiql/rails'),
    chunkFormat: false,
  },
};
