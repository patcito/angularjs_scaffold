require 'rails/generators'
require 'rails/generators/generated_attribute'

module Angularjs
  class ScaffoldGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    argument :controller_name, :type => :string

    # HACK ALERT
    # Since I can't find a thor method that checks for the existence of a file,
    # I am forced to hackery.  I assume that the language selected was 'javascript'.
    # I attempt to add a blank line to the end of 'app/assets/javascripts/routes.js.erb', 
    # and if that fails, then I catch the exception and assume that the selected language option is 'coffeescript'
    def language_option
      answer = 'javascript'
      begin
        append_to_file "app/assets/javascripts/routes.js.erb", "\n"
      rescue Exception
        answer = 'coffeescript'
      end
      answer
    end

    def init_vars
      @model_name = controller_name.singularize #"Post"
      @controller = controller_name #"Posts"
      @resource_name = @model_name.demodulize.underscore #post
      @plural_model_name = @resource_name.pluralize #posts
      @model_name.constantize.columns.
        each{|c|
          (['name','title'].include?(c.name)) ? @resource_legend = c.name.capitalize : ''}
      @resource_legend = 'ID' if @resource_legend.blank?
      @language = language_option # 'coffeescript or javascript'
    end

    def columns
      begin
        excluded_column_names = %w[id _id _type created_at updated_at]
        @model_name.constantize.columns.
          reject{|c| excluded_column_names.include?(c.name) }.
          collect{|c| ::Rails::Generators::GeneratedAttribute.
                  new(c.name, c.type)}
      rescue NoMethodError
        @model_name.constantize.fields.
          collect{|c| c[1]}.
          reject{|c| excluded_column_names.include?(c.name) }.
          collect{|c|
            ::Rails::Generators::GeneratedAttribute.
              new(c.name, c.type.to_s)}
      end
    end

    def generate
      remove_file "app/assets/stylesheets/scaffolds.css.scss"
      append_to_file "app/assets/javascripts/application.js",
        "//= require #{@plural_model_name}_controller \n"
      append_to_file "app/assets/javascripts/application.js",
        "//= require #{@plural_model_name} \n"
      if @language == 'coffeescript'
        insert_into_file "app/assets/javascripts/routes.coffee.erb",
        ", \'#{@plural_model_name}\'", :before => "]"
        insert_into_file "app/assets/javascripts/routes.coffee.erb",
%{when("/#{@plural_model_name}", 
    controller: #{@controller}IndexCtrl
    templateUrl: "<%= asset_path(\"#{@plural_model_name}/index.html\") %>"
  ).when("/#{@plural_model_name}/new",
    controller: #{@controller}CreateCtrl
    templateUrl: "<%= asset_path(\"#{@plural_model_name}/new.html\") %>"
  ).when("/#{@plural_model_name}/:id",
    controller: #{@controller}ShowCtrl
    templateUrl: "<%= asset_path(\"#{@plural_model_name}/show.html\") %>"
  ).when("/#{@plural_model_name}/:id/edit",
    controller: #{@controller}EditCtrl
    templateUrl: "<%= asset_path(\"#{@plural_model_name}/edit.html\") %>"
  ).}, :before => 'otherwise'
      else
        insert_into_file "app/assets/javascripts/routes.js.erb",
        ", '#{@plural_model_name}'", :after => "'ngCookies'"
        insert_into_file "app/assets/javascripts/routes.js.erb",
%{    when('/#{@plural_model_name}', {controller:#{@controller}IndexCtrl,
         templateUrl:'<%= asset_path("#{@plural_model_name}/index.html") %>'}).
    when('/#{@plural_model_name}/new', {controller:#{@controller}CreateCtrl,
                templateUrl:'<%= asset_path("#{@plural_model_name}/new.html") %>'}).
    when('/#{@plural_model_name}/:id', {controller:#{@controller}ShowCtrl,
         templateUrl:'<%= asset_path("#{@plural_model_name}/show.html") %>'}).
    when('/#{@plural_model_name}/:id/edit', {controller:#{@controller}EditCtrl,
         templateUrl:'<%= asset_path("#{@plural_model_name}/edit.html") %>'}).\n
}, :before => 'otherwise'
      end
      
      inject_into_class "app/controllers/#{@plural_model_name}_controller.rb",
        "#{@controller}Controller".constantize, "respond_to :json\n"
      template "new.html.erb",
        "app/assets/templates/#{@plural_model_name}/new.html.erb"
      template "edit.html.erb",
        "app/assets/templates/#{@plural_model_name}/edit.html.erb"
      template "show.html.erb",
        "app/assets/templates/#{@plural_model_name}/show.html.erb"
      template "index.html.erb",
        "app/assets/templates/#{@plural_model_name}/index.html.erb"
      
      if @language == 'coffeescript'
        template "cs/plural_model_name.js.coffee", "app/assets/javascripts/#{@plural_model_name}.js.coffee"
        template "cs/plural_model_name_controller.js.coffee",
          "app/assets/javascripts/#{@plural_model_name}_controller.js.coffee"
      else
        template "js/plural_model_name.js", "app/assets/javascripts/#{@plural_model_name}.js"
        template "js/plural_model_name_controller.js",
          "app/assets/javascripts/#{@plural_model_name}_controller.js"
        # remove the default .js.coffee file added by rails.
        remove_file "app/assets/javascripts/#{@plural_model_name}.js.coffee"
      end
    end
  end
end
