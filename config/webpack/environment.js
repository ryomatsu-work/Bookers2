require('dotenv').config()

const { environment } = require('@rails/webpacker')

module.exports = environment

const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    // $: 'jquery/src/jquery', // it will be bug when using jpostal
    // jQuery: 'jquery/src/jquery',
    $: 'jquery',
    jQuery: 'jquery',
    Popper: 'popper.js'
  })
)


