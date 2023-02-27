;(function () {
  class Plugin {
    name = 'VariantDescriptionPlugin'
    version = '1.0'

    install(pluginManager) {
      pluginManager.jexl.addFunction('variantDescription', f => {

    var type = f.get('INFO').soTerm;
    type = type[0];
    if (type == 'point_mutation') {
        type = 'SNV';
    }
    var ref_allele = f.get('REF');
    var alt_allele = f.get('ALT');
    alt_allele = alt_allele[0]
    if (alt_allele == '<R>') {
        alt_allele = 'A or G';
    }
    else if (alt_allele == '<Y>') {
        alt_allele = 'C or T';
    }
    else if (alt_allele == '<S>') {
        alt_allele = 'C or G';
    }
    else if (alt_allele == '<W>') {
        alt_allele = 'A or T';
    }
    else if (alt_allele == '<M>') {
        alt_allele = 'A or C';
    }
    else if (alt_allele == '<K>') {
        alt_allele = 'G or T';
    }
    else if (alt_allele == '<B>') {
        alt_allele = 'C, G, or T';
    }
    else if (alt_allele == '<D>') {
        alt_allele = 'A, G or T';
    }
    else if (alt_allele == '<H>') {
        alt_allele = 'A, C or T';
    }
    else if (alt_allele == '<H>') {
        alt_allele = 'A, C or G';
    }
    if (alt_allele.substring(alt_allele.length-1) == '.') {
        alt_allele = alt_allele.substring(0,1).toLowerCase()+ 'N+';
    }
    if (ref_allele.length > 20) {
        ref_allele = ref_allele.substring(0,1).toLowerCase()+ref_allele.substring(1,7).toUpperCase()+ '...' +ref_allele.substring(ref_allele.length-7).toUpperCase();
    }
    else if (type == 'delins' || type == 'insertion' || type == 'deletion') {
        ref_allele = ref_allele.substring(0,1).toLowerCase()+ref_allele.substring(1).toUpperCase();
    }
    if (alt_allele.length > 20) {
        alt_allele = alt_allele.substring(0,1).toLowerCase()+alt_allele.substring(1,7).toUpperCase()+ '...' +alt_allele.substring(alt_allele.length-7).toUpperCase();
    }
    else if ((type == 'delins' || type == 'insertion' || type == 'deletion') && alt_allele.indexOf('+')<0) {
        alt_allele = alt_allele.substring(0,1).toLowerCase()+alt_allele.substring(1).toUpperCase();
    }
    return type+' '+ref_allele+' -> '+alt_allele;
      
      })
    }

    configure(pluginManager) {}
  }

  // the plugin will be included in both the main thread and web worker, so
  // install plugin to either window or self (webworker global scope)
  ;(typeof self !== 'undefined' ? self : window).JBrowsePluginVariantDescriptionPlugin =
    {
      default: Plugin,
    }
})()

