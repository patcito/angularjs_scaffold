angular.module('<%= @plural_model_name%>', ['ngResource']).
  factory('<%= @model_name%>', ['$resource', function($resource) {
  var <%= @model_name%> = $resource('/<%= @plural_model_name%>/:id', {id: '@id'},
                       {
                         update: { method: 'PUT' },
                         destroy: { method: 'DELETE'}
                       }
                      );

  <%= @model_name%>.prototype.destroy = function(cb) {
    return <%= @model_name%>.remove({id: this.id}, cb);
  };

  return <%= @model_name%>;
}]);
