exports.config = {
  "modules": [
    "copy",
    "server",
    "jshint",
    "csslint",
    "require",
    "minify-js",
    "minify-css",
    "live-reload",
    "bower",
    "coffeescript",
    "less",
    "jade"
  ],
  "template": {
    "outputFileName": "javascripts/consumer-templates"
  },
  require: {
    commonConfig: 'requirejs-config'
  }
}