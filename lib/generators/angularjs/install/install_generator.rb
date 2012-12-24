module Angularjs
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    class_option 'layout-type', :type => :string, :default => "fixed",
      :banner => "*fixed or fluid", :aliases => ["-lt"]
    class_option 'no-jquery', :type => :boolean, :aliases => ["-njq"],
      desc: "Don't include jquery"
    class_option 'no-bootstrap', :type => :boolean, :aliases => ["-nb"],
      desc: "Don't include bootstrap"
    class_option 'language', :type => :string, :default => 'coffeescript', :aliases => ["-ln"],
      desc: "Choose your preferred language, 'coffeescript' or 'javascript' "

    def init_angularjs
      if File.exist?("app/assets/javascripts/application.js")
        insert_into_file "app/assets/javascripts/application.js",
          "//= require_tree ./angularjs/\n", :after => "jquery_ujs\n"
      else
        copy_file "application.js", "app/assets/javascripts/application.js"
      end
      @application_css_file ="app/assets/stylesheets/application.css"
      if (!(File.exist?("app/assets/stylesheets/application.css")) &&
          File.exist?("app/assets/stylesheets/application.css.scss"))
        @application_css_file ="app/assets/stylesheets/application.css.scss"
      elsif !File.exist?("app/assets/stylesheets/application.css")
        create_file @application_css_file
      end
      directory "underscore", "app/assets/javascripts/underscore/"
      directory "angularjs", "app/assets/javascripts/angularjs/"
      if options["no-jquery"]
        gsub_file "app/assets/javascripts/application.js",
          /\/\/= require jquery_ujs\n/, ''
        gsub_file "app/assets/javascripts/application.js",
          /\/\/= require jquery\n/, ''
        #gsub_file "app/assets/javascripts/application.js",
        #  /^$\n/, ''
      end
    end

    def init_twitter_bootstrap_assets
      unless options["no-bootstrap"]
        directory "fonts", "app/assets/fonts/"
        directory "fontawesome", "app/assets/stylesheets/fontawesome/"
        directory "bootstrap/css", "app/assets/stylesheets/bootstrap/"
        directory "bootstrap/js", "app/assets/javascripts/bootstrap/"
        directory "bootstrap/img", "app/assets/javascripts/img/"
        insert_into_file @application_css_file,
          " *= require bootstrap/bootstrap.min.css\n", :after => "require_self\n"
        insert_into_file @application_css_file,
          " *= require bootstrap/bootstrap-responsive.min.css\n",
          :after => "bootstrap.min.css\n"
        insert_into_file @application_css_file,
          " *= require fontawesome/font-awesome.css\n",
          :after => "bootstrap-responsive.min.css\n"
        append_to_file @application_css_file,
          "\nbody { padding-top: 60px; }\n"
        unless options["no-jquery"]
          insert_into_file "app/assets/javascripts/application.js",
            "//= require_tree ./bootstrap/\n", :after => "angularjs/\n"
        end
      end
    end

    attr_reader :app_name, :container_class, :language
    def init_twitter_bootstrap_layout
      @app_name = Rails.application.class.parent_name
      @container_class = options["layout-type"] == "fluid" ? "container-fluid" : "container"
      @language = options["language"] == 'javascript' ? "javascript" : "coffeescript"
      template "application.html.erb", "app/views/layouts/application.html.erb"
    end

    def generate_welcome_controller
      remove_file "public/index.html"
      uncomment_lines 'config/routes.rb', /root :to => 'welcome#index'/
        run "rails g controller welcome index"
      copy_file "AngularJS-medium.png", "app/assets/images/AngularJS-medium.png"
      copy_file 'favicon.ico', "app/assets/images/favicon.ico"
      empty_directory "app/assets/templates"
      empty_directory "app/assets/templates/welcome"
      copy_file "index_welcome.html.erb", "app/assets/templates/welcome/index.html.erb"
      if @language == 'coffeescript'
        copy_file "routes.coffee.erb", "app/assets/javascripts/routes.coffee.erb"
        insert_into_file "app/assets/javascripts/routes.coffee.erb", @app_name, before: 'Client'
        ['csrf', 'welcome'].each do |prefix| 
          copy_file "#{prefix}_controller.js.coffee",
            "app/assets/javascripts/#{prefix}_controller.js.coffee"
        end
        insert_into_file "app/assets/javascripts/welcome_controller.js.coffee", @app_name, before: 'Client'
      else
        copy_file "routes.js.erb", "app/assets/javascripts/routes.js.erb"
        insert_into_file "app/assets/javascripts/routes.js.erb", @app_name, before: 'Client'
        ['csrf', 'welcome'].each do |prefix| 
          copy_file "#{prefix}_controller.js",
            "app/assets/javascripts/#{prefix}_controller.js"
        end
        insert_into_file "app/assets/javascripts/welcome_controller.js", @app_name, before: 'Client'
      end
      append_to_file "app/assets/javascripts/application.js",
        "//= require routes\n"
      append_to_file "app/assets/javascripts/application.js",
        "//= require welcome_controller\n"
      append_to_file @application_css_file,
        ".center {text-align: center;}\n"
      insert_into_file "app/controllers/application_controller.rb",
%{
  private

  # AngularJS automatically sends CSRF token as a header called X-XSRF
  # this makes sure rails gets it
  def verified_request?
    !protect_against_forgery? || request.get? ||
      form_authenticity_token == params[request_forgery_protection_token] ||
      form_authenticity_token == request.headers['X-XSRF-Token']
  end
 }, :before => "end"

    end
  end
end
