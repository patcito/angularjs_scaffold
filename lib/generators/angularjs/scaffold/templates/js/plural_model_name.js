angular.module('<%= @plural_model_name%>', ['ngResource']).
  factory('<%= @model_name%>', function($resource) {
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
});
/*
angular.module('<%= @plural_model_name%>', ['ngResource']).
  factory('<%= @model_name%>', function($resource) {
  var <%= @model_name%> = $resource('/<%= @plural_model_name%>/:id',
                       {}, {
                         update: { method: 'PUT' },
                         destroy: { method: 'DELETE'}
                       }
                      );

                      <%= @model_name%>.prototype.update = function(cb) {
                        return <%= @model_name%>.update({id: this._id},
                                           angular.extend({},
                                                          this,
                                                          {id:undefined}), cb);
                      };

                      <%= @model_name%>.prototype.destroy = function(cb) {
                        return <%= @model_name%>.remove({id: this._id}, cb);
                      };

                      return <%= @model_name%>;
});
*/
