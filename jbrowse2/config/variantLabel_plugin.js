;(function () {
  class Plugin {
    name = 'VariantLabelPlugin'
    version = '1.0'

    install(pluginManager) {
      pluginManager.jexl.addFunction('variantLabel', f => {

        const symbols = f.get('INFO').allele_symbols 
        if (! (typeof symbols=== 'undefined') ) {
            var temp = symbols[0].replace('<sup>', '<').replace('</sup>','>');
            return temp;
        }

        const name = f.get('name')
        if (! (typeof name === 'undefined') ) {
            var temp = name.replace('<sup>', '<').replace('</sup>','>');
            return temp;
        }
        return 'no name';
      
      })
    }

    configure(pluginManager) {}
  }

  // the plugin will be included in both the main thread and web worker, so
  // install plugin to either window or self (webworker global scope)
  ;(typeof self !== 'undefined' ? self : window).JBrowsePluginVariantLabelPlugin =
    {
      default: Plugin,
    }
})()

