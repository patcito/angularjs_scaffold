<%= @controller %>IndexCtrl = function($scope, <%= @model_name %>) {
  $scope.<%= @plural_model_name %> = <%= @model_name %>.query();
  
  return $scope.destroy = function() {
    var original;
    if (confirm("Are you sure?")) {
      original = this.<%= @resource_name %>;
      return this.<%= @resource_name %>.destroy(function() {
        return $scope.<%= @plural_model_name %> = _.without($scope.<%= @plural_model_name %>, original);
      });
    }
  };
};

<%= @controller %>IndexCtrl.$inject = ['$scope', '<%= @model_name %>'];

<%= @controller %>CreateCtrl = function($scope, $location, <%= @model_name %>) {
  return $scope.save = function() {
    return <%= @model_name %>.save($scope.<%= @resource_name %>, function(<%= @resource_name %>) {
      return $location.path("/<%= @plural_model_name %>/" + <%= @resource_name %>.id + "/edit");
    });
  };
};

<%= @controller %>CreateCtrl.$inject = ['$scope', '$location', '<%= @model_name %>'];

<%= @controller %>ShowCtrl = function($scope, $location, $routeParams, <%= @model_name %>) {
  <%= @model_name %>.get({
    id: $routeParams.id
  }, function(<%= @resource_name %>) {
    this.original = <%= @resource_name %>;
    return $scope.<%= @resource_name %> = new <%= @model_name %>(this.original);
  });
  return $scope.destroy = function() {
    if (confirm("Are you sure?")) {
      return $scope.<%= @resource_name %>.destroy(function() {
        return $location.path("/<%= @plural_model_name %>");
      });
    }
  };
};

<%= @controller %>ShowCtrl.$inject = ['$scope', '$location', '$routeParams', '<%= @model_name %>'];

<%= @controller %>EditCtrl = function($scope, $location, $routeParams, <%= @model_name %>) {
  <%= @model_name %>.get({
    id: $routeParams.id
  }, function(<%= @resource_name %>) {
    this.original = <%= @resource_name %>;
    return $scope.<%= @resource_name %> = new <%= @model_name %>(this.original);
  });
  $scope.isClean = function() {
    return angular.equals(this.original, $scope.<%= @resource_name %>);
  };
  $scope.destroy = function() {
    if (confirm("Are you sure?")) {
      return $scope.<%= @resource_name %>.destroy(function() {
        return $location.path("/<%= @plural_model_name %>");
      });
    }
  };
  return $scope.save = function() {
    return <%= @model_name %>.update($scope.<%= @resource_name %>, function(<%= @resource_name %>) {
      return $location.path("/<%= @plural_model_name %>");
    });
  };
};

<%= @controller %>EditCtrl.$inject = ['$scope', '$location', '$routeParams', '<%= @model_name %>'];


