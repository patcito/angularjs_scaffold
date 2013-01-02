## AngularjsScaffold + CoffeeScript

## Now works with minified dependency injection!!

A rails plugin for scaffolding views using Angular.js, Twitter bootstrap
and font awesome

This project uses MIT-LICENSE.

First install the gem or add it to your Gemfile:

    $ gem install explainer_angularjs_scaffold

Second install it, this will add angularjs, bootstrap and fontawesome (there's an option to only install AngularJS)

    $ rails g angularjs:install # adds angular.js and a dummy welcome JS controller

    options:  

      --layout-type=fixed [fluid]
      --no-jquery
      --no-bootstrap
      --language=coffeescript [javascript]  NOTE: this setting will be set for the entire rails app 
        and will affect all subsequent 'rails generate angularjs:scaffold <<model>>' commands

Run your usual scaffold command:

    $ rails g scaffold Post title:string body:string
    $ rake db:migrate

Now run the angularjs:scaffold command and it will rewrite everything the AngularJS way:

    $ rails g angularjs:scaffold Posts # adds everything needed using AngularJS

The "AngularJS way", in my opinion, follows the Unobtrusive Javascript paradigm, but uses CoffeeScript in place of Javascript.  To me, Javascript is like programming in Assembler, while CoffeeScript is much more readable, and produces very high quality JS as output.  When combined with the Rails asset pipeline, CoffeeScript has a lot of advantages, and little or no downside.  What's not to like?  But, you have the install-time option --language=javascript.

The name given the AngularJS app is based on the Rails app name, plus 'Client', so a rails app named 'Sue' would deploy an AngularJS app 'SueClient' to the browser.  

Another change I made to this scaffold is adding the .erb extension on the generated template files, so 

    index.html 

becomes 

    index.html.erb

No big deal, but this makes it clear that the AngularJS templates can take advantage of 'server-side provisioning'.  If that term is unclear, I suggest you look at the file 

    routes.coffee.erb

where the AngularJS routes are populated by Rails route helpers.  It just makes sense that the server should specify to the view how it should be accessed.

Enjoy!
