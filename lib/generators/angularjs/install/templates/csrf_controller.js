var CsrfCtrl = ["$cookieStore", function($cookieStore) {
    return $cookieStore.put("XSRF-TOKEN", 
      angular.element(document.getElementById("csrf")).attr("data-csrf"));
  }
];