root = global ? window

CsrfCtrl = ["$cookieStore", ($cookieStore) ->
  $cookieStore.put "XSRF-TOKEN", 
  angular.element(document.getElementById("csrf")).attr("data-csrf")
]
# exports
root.CsrfCtrl = CsrfCtrl