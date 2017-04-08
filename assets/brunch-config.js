exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: 'js/app.js'

      // To use a separate vendor.js bundle, specify two files path
      // https://github.com/brunch/brunch/blob/master/docs/config.md#files
      // joinTo: {
      //  'js/app.js': /^(js)/,
      //  'js/vendor.js': /^(vendor)|(deps)/
      // }
      //
      // To change the order of concatenation of files, explicitly mention here
      // https://github.com/brunch/brunch/tree/master/docs#concatenation
      // order: {
      //   before: [
      //     'vendor/js/jquery-2.1.1.js',
      //     'vendor/js/bootstrap.min.js'
      //   ]
      // }
    },
    stylesheets: {
      joinTo: 'css/app.css'
    },
    templates: {
      joinTo: 'js/app.js'
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to '/assets/static'. Files in this directory
    // will be copied to `paths.public`, which is 'priv/static' by default.
    assets: /^(static)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: ['static', 'css', 'js', 'vendor'],
    // Where to compile files to
    public: '../priv/static'
  },

  // Configure your plugins
  plugins: {
    sass: {
      mode: 'native'
    },
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/vendor/],
      presets: [ 'latest', 'react' ], //, ['transform-class-properties', {spec: true}]]
      plugins: ['transform-object-rest-spread', 'transform-class-properties', 'transform-react-jsx']
    }
  },

  modules: {
    autoRequire: {
      'js/app.js': ['js/app']
    }
  },

  npm: {
    globals: {
      '$': 'materialize-css/node_modules/jquery/dist/jquery.js',
      'jQuery': 'materialize-css/node_modules/jquery/dist/jquery.js',
      'Vel': 'velocity-animate'
    },
    javascripts: {
      'material-css': ['dist/js/materialize.min']
    },
    styles: {
      'picdate': ['lib/themes/default.date.css',
        'lib/themes/default.css'],
      'materialize-css': ['dist/css/materialize.css']
    },
    enabled: true,
    whitelist: ['phoenix', 'phoenix_html', 'react',
      'react-dom', 'redux', 'react-redux']
  }
};
