const path = require('path');

module.exports = () => {
  return {
    context: __dirname,
    entry: './src/react_minesweeper.jsx',
    output: {
      path: path.resolve(__dirname) + '/dist/',
      filename: 'bundle.js',
    },
    module: {
      rules: [
        {
          test: /\.jsx?$/,
          exclude: /(node_modules)/,
          use: {
            loader: 'babel-loader'
          },
        }
      ]
    },
    devtool: 'source-map',
    resolve: {
      extensions: ['.js', '.jsx', '*']
    }
  };
};