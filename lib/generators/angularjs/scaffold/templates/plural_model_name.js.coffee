root = global ? window

angular.module(<%= "#{@plural_model_name}" %>, ["ngResource"]).factory <%= "#{@model_name}" %>, ($resource) ->
  <%= "#{@model_name}" %> = $resource(<%= "/#{@plural_model_name}/:id" %>,
    id: "@id"
  ,
    update:
      method: "PUT"

    destroy:
      method: "DELETE"
  )
  <%= "#{@model_name}" %>::destroy = (cb) ->
    <%= "#{@model_name}" %>.remove
      id: @id
    , cb

  <%= "#{@model_name}" %>

root.<%= "#{@model_name}"%> = <%= "#{@model_name}" %>
