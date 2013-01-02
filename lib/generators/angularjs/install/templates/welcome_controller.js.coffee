root = global ? window

WelcomeCtrl = ["$scope", ($scope) ->
]
WelcomeCtrl.$inject ['$scope', WelcomeCtrl]

# exports
root.thisApp.controller "WelcomeCtrl", WelcomeCtrl

