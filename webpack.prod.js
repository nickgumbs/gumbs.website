const { merge } = require('webpack-merge');
const common = require('./webpack.common.js');
const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CssMinimizerPlugin = require('css-minimizer-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = merge(common, {
  mode: 'production',
  output: {
    filename: '[name].[contenthash].js',
    path: path.resolve(__dirname, 'dist'),
    clean: true,
  },
  devtool: 'source-map',
  module: {
    rules: [
      {
        test: /\.css$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader'],
      }
    ],
  },
  optimization: {
    minimize: true,
    minimizer: [
      `...`,
      new CssMinimizerPlugin(), // Only CSS optimization
    ],
  },
  plugins: [
    new MiniCssExtractPlugin({
      filename: '[name].[contenthash].css',
    }),
    new CopyWebpackPlugin({
      patterns: [
        {
          from: 'public',
          to: '.',
          globOptions: {
            ignore: ['**/index.html']
          }
        }
      ],
    })
  ],
});
