
root = global ? window

<%= @controller %>IndexCtrl = ($scope, <%= @model_name %>) ->
  $scope.<%= @plural_model_name %> = <%= @model_name %>.query()

  $scope.destroy = ->
    if confirm("Are you sure?")
      original = @<%= @resource_name %>
      @<%= @resource_name %>.destroy ->
        $scope.<%= @plural_model_name %> = _.without($scope.<%= @plural_model_name %>, original)
        
<%= @controller %>IndexCtrl.$inject = ['$scope', '<%= @model_name %>'];

<%= @controller %>CreateCtrl = ($scope, $location, <%= @model_name %>) ->
  $scope.save = ->
    <%= @model_name %>.save $scope.<%= @resource_name %>, (<%= @resource_name %>) ->
      $location.path "/<%= @plural_model_name %>/#{<%= @resource_name %>.id}/edit"

<%= @controller %>CreateCtrl.$inject = ['$scope', '$location', '<%= @model_name %>'];

<%= @controller %>ShowCtrl = ($scope, $location, $routeParams, <%= @model_name %>) ->
  <%= @model_name %>.get
    id: $routeParams.id
  , (<%= @resource_name %>) ->
    @original = <%= @resource_name %>
    $scope.<%= @resource_name %> = new <%= @model_name %>(@original)

  $scope.destroy = ->
    if confirm("Are you sure?")
      $scope.<%= @resource_name %>.destroy ->
        $location.path "/<%= @plural_model_name %>"

<%= @controller %>ShowCtrl.$inject = ['$scope', '$location', '$routeParams', '<%= @model_name %>'];

<%= @controller %>EditCtrl = ($scope, $location, $routeParams, <%= @model_name %>) ->
  <%= @model_name %>.get
    id: $routeParams.id
  , (<%= @resource_name %>) ->
    @original = <%= @resource_name %>
    $scope.<%= @resource_name %> = new <%= @model_name %>(@original)

  $scope.isClean = ->
    console.log "[<%= @controller %>EditCtrl, $scope.isClean]"
    angular.equals @original, $scope.<%= @resource_name %>

  $scope.destroy = ->
    if confirm("Are you sure?")
      $scope.<%= @resource_name %>.destroy ->
        $location.path "/<%= @plural_model_name %>"

  $scope.save = ->
    <%= @model_name %>.update $scope.<%= @resource_name %>, (<%= @resource_name %>) ->
      $location.path "/<%= @plural_model_name %>"

<%= @controller %>EditCtrl.$inject = ['$scope', '$location', '$routeParams', '<%= @model_name %>'];

# exports
root.<%= @controller %>IndexCtrl  = <%= @controller %>IndexCtrl
root.<%= @controller %>CreateCtrl = <%= @controller %>CreateCtrl
root.<%= @controller %>ShowCtrl   = <%= @controller %>ShowCtrl
root.<%= @controller %>EditCtrl   = <%= @controller %>EditCtrl 