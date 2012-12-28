root = global ? window

<%= @controller %>IndexCtrl = ["$scope", "<%= @model_name %>", ($scope, <%= @model_name %>) ->
  $scope.<%= @plural_model_name %> = <%= @model_name %>.query()
  $scope.destroy = ->
    dconfirm = confirm("Are you sure?")
    if dconfirm
      original = @<%= @resource_name %>
      @<%= @resource_name %>.destroy ->
        $scope.<%= @plural_model_name %> = _.without($scope.<%= @plural_model_name %>, original)

]
<%= @controller %>CreateCtrl = ["$scope", "$location", "<%= @model_name %>", ($scope, $location, <%= @model_name %>) ->
  $scope.save = ->
    <%= @model_name %>.save $scope.<%= @resource_name %>, (<%= @resource_name %>) ->
      $location.path "/<%= @plural_model_name %>/" + <%= @resource_name %>.id + "/edit"

]
<%= @controller %>ShowCtrl = ["$scope", "$location", "$routeParams", "<%= @model_name %>", ($scope, $location, $routeParams, <%= @model_name %>) ->
  <%= @model_name %>.get
    id: $routeParams.id
  , (<%= @resource_name %>) ->
    self.original = <%= @resource_name %>
    $scope.<%= @resource_name %> = new <%= @model_name %>(self.original)

]
<%= @controller %>EditCtrl = ["$scope", "$location", "$routeParams", "<%= @model_name %>", ($scope, $location, $routeParams, <%= @model_name %>) ->
  self = this
  <%= @model_name %>.get
    id: $routeParams.id
  , (<%= @resource_name %>) ->
    self.original = <%= @resource_name %>
    $scope.<%= @resource_name %> = new <%= @model_name %>(self.original)

  $scope.isClean = ->
    angular.equals self.original, $scope.<%= @resource_name %>

  $scope.destroy = ->
    dconfirm = confirm("Are you sure?")
    if dconfirm
      $scope.<%= @resource_name %>.destroy ->
        $location.path "/<%= @plural_model_name %>"


  $scope.save = ->
    <%= @model_name %>.update $scope.<%= @resource_name %>, (<%= @resource_name %>) ->
      $location.path "/<%= @plural_model_name %>"

]
# exports
root.<%= @controller %>IndexCtrl  = <%= @controller %>IndexCtrl
root.<%= @controller %>CreateCtrl = <%= @controller %>CreateCtrl
root.<%= @controller %>ShowCtrl   = <%= @controller %>ShowCtrl
root.<%= @controller %>EditCtrl   = <%= @controller %>EditCtrl 
