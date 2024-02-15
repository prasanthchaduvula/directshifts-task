const webpack = require("webpack");
const aliasConfig = require("./alias");
const { webpackConfig, merge } = require("shakapacker");

let customConfig = {
  plugins: [
    new webpack.ProvidePlugin({
    }),
  ],
};

const resolveOptions = {
  resolve: {
    extensions: [
      ".css",
      ".ts",
      ".tsx",
      ".js",
      ".jsx",
      ".png",
      ".svg",
      ".gif",
      ".jpeg",
      ".jpg",
      ".woff",
      ".woff2",
      ".ico",
      ".scss"
    ],
  },
};

customConfig = merge({}, customConfig, resolveOptions, aliasConfig);

module.exports = merge(webpackConfig, customConfig);
