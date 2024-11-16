const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  entry: './src/index.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist'),
  },
  devServer: {
    static: {
      directory: path.join(__dirname, 'public'),
    },
    port: 8080,
  },
  module: {
    rules: [
      {
        test: /\.css$/,  // Match .css files
        use: [
          'style-loader',
          'css-loader'
        ]
      },
      {
        test: /\.hbs$/, // Handlebars templates
        loader: 'handlebars-loader',
        options: {
          helperDirs: path.join(__dirname, 'src/helpers'),
          precompileOptions: {
            knownHelpersOnly: false,
          },
          partialDirs: [
            path.join(__dirname, 'src/templates/partials'),  // Path to the partials folder
          ],
        },
      },
      {
        test: /\.(png|svg|jpg|jpeg|gif)$/i, // For images
        type: 'asset/resource',
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
        },
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: './public/index.html',
    }),

  ],
  mode: 'development', // Change to 'production' for builds
};
