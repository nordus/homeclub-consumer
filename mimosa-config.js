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
  },
  copy: {
    extensions: ["js",  "css", "png", "jpg",
      "jpeg","gif", "html","php",
      "eot", "svg", "ttf", "woff",
      "otf", "yaml","kml", "ico",
      "htc", "htm", "json","txt",
      "xml", "xsd", "map", "md",
      "mp4", "woff2"]
  }
}