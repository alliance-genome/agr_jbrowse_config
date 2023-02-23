;(function () {
  class Plugin {
    name = 'MultiVariantColorPlugin'
    version = '1.0'

    install(pluginManager) {
      pluginManager.jexl.addFunction('multiVariantColor', f => {

        const result = f.get('geneimpacts') || []
        console.log(result)
        var cons = []
        if (Array.isArray(result)) {
            cons = result 
        } else {
            cons.push(result)
        }
        console.log(cons)
        if (cons.includes('HIGH')) return 'red'
        if (cons.includes('MODIFIER')) return 'purple'
        if (cons.includes('MODERATE')) return 'gold'
        if (cons.includes('LOW')) return 'cyan'
        return 'black'
      
      })
    }

    configure(pluginManager) {}
  }

  // the plugin will be included in both the main thread and web worker, so
  // install plugin to either window or self (webworker global scope)
  ;(typeof self !== 'undefined' ? self : window).JBrowsePluginMultiVariantColorPlugin =
    {
      default: Plugin,
    }
})()

