/* eslint-disable no-undef */
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  mode: 'development',
  entry: {
    main: './src/index.js',
  },
  output: {
    filename: 'bundle.js',
    publicPath: '/',
    path: path.resolve(__dirname, 'dist'),
  },
  module: {
    rules: [{
      test: /\.(js|jsx)$/,
      use: 'babel-loader',
      exclude: /node_modules/,
    }, {
      test: /\.css$/,
      use: ['style-loader'],
      exclude: /node_modules/,
    }],
  },
  devServer: {
    contentBase: path.join(__dirname, 'dist'),
    publicPath: '/',
    overlay: true,
    stats: 'errors-only',
    historyApiFallback: true,
    proxy: {
      '/api': 'http://localhost:3000',
    },
  },
  devtool: 'cheap-eval-source-map',
  plugins: [
    new HtmlWebpackPlugin({
      template: './src/index.html',
    })],
  resolve: {
    extensions: ['.js', '.jsx'],
  },
};
