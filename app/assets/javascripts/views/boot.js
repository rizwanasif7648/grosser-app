var BOOT = {
  exec: function(pageName) {
    var ns = com.healApp,
      initFunc = "init";

    if (pageName !== "" && ns[pageName] && typeof ns[pageName][initFunc] == "function") {
      ns[pageName][initFunc]();
    }
  },

  init: function() {
    var bodyId     = $("body").attr("id").split("-"),
      controller = this._camelize(bodyId[0], true),
      action     = this._camelize(bodyId[1], true),
      pageName   = controller + action;
    this.exec(pageName);
  },

  _camelize: function(str, all) {
    all = all || false;
    var parts = str.split('_'),
      len = parts.length;

    if (len == 1) {
      return !all ? parts[0] : parts[0].charAt(0).toUpperCase() + parts[0].substring(1);;
    }

    var camelized = !all ? parts[0] : parts[0].charAt(0).toUpperCase() + parts[0].substring(1);
    for (var i = 1; i < len; i++) {
      camelized += parts[i].charAt(0).toUpperCase() + parts[i].substring(1);
    }

    return camelized;
  }
};

$(document).ready(function() {

  BOOT.init();
});
