;(function () {
  class Plugin {
    name = 'HTVariantColorPlugin'
    version = '1.0'

    install(pluginManager) {
      pluginManager.jexl.addFunction('htVariantColor', f => {

        const csq = f.get('INFO')?.CSQ || []
        const cons = csq.map(line => line.split('|')[2])
        if (cons.includes('HIGH')) return 'red'
        else if (cons.includes('MODIFIER')) return 'purple'
        else if (cons.includes('MODERATE')) return 'gold'
        else if (cons.includes('LOW')) return 'cyan'
        return 'black'
/*
            var cons = [];
            if (   typeof f !== 'undefined'
                && typeof f.variant !=='undefined'
                && typeof f.variant.INFO !== 'undefined'
                && typeof f.variant.INFO.CSQ !== 'undefined') {
                var csq = f.variant.INFO.CSQ;
                if (csq === 'undefined') {return 'black'}
                if (!Array.isArray(csq)) {return 'green'}
                
                csq.forEach(function(line) {
                    if (typeof line === 'undefined') {return 'pink'}
                    var tmp = line.split('|')[2]
                    if (typeof tmp === 'undefined') {return 'lightgreen'}
                    cons.push(tmp)
                })
            } else {return 'black'}
            console.log(cons); 
            cons.forEach(function(item) {
                if (item=='HIGH')     {return 'red'} 
            }) 

            cons.forEach(function(item) {
                console.log('--'+item+'--')
                if (item=='MODIFIER') {return 'purple'}
            }) 

            cons.forEach(function(item) {
                if (item=='MODERATE') {return 'gold'}
            })

            cons.forEach(function(item) {
                if (item=='LOW')      {return 'cyan'}
            })

            return 'violet';
*/
      })
    }

    configure(pluginManager) {}
  }

  // the plugin will be included in both the main thread and web worker, so
  // install plugin to either window or self (webworker global scope)
  ;(typeof self !== 'undefined' ? self : window).JBrowsePluginHTVariantColorPlugin =
    {
      default: Plugin,
    }
})()

