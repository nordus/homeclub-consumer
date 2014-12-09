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
    "jade",
    "web-package"
  ],
  "template": {
    "outputFileName": "javascripts/consumer-templates"
  },
  require: {
    commonConfig: 'requirejs-config'
  },
  minifyJS: {
    mangleNames: false
  }
}