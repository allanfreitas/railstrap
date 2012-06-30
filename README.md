# Railstrap
Bootstrap Tools for Rails 3, Generate Layouts and CRUDs, Helpers and more...

## Installing Gem

Include Bootstrap in Gemfile;

```
gem "railstrap"
```

or you can install from latest build;

```
gem 'railstrap', :git => 'git://github.com/allanfreitas/railstrap.git'
```

You can run bundle from command line

    bundle install



## Genenators Usage:

### Layout Generator
    rails generate railstrap:layout [LAYOUT_NAME] [options]
#### Options:
    [--no-assets]                # Use this option if you want to generate only the Layout File
    [--layout-type=LAYOUT_TYPE]  # Layout type, admin or sign 
                                 # Default: admin
    [--app-name=APP_NAME]        # Specify the application name # Default: Railstrap Painel
    [--no-layout]                # Use this option if you want to generate only stylesheets


### CRUD Generator (controller and views):
    rails generate railstrap:crud NAME MODEL_NAME [options]

#### Options:
    [--no-controller]             # Sem controller
    [--no-views]                  # Sem Views
    [--kaminari]                  # Specify if you use Kaminari
    [--themed-type=THEMED_TYPE]   # Specify the themed type: crud, list or show. Default is crud



## Features
  * Scaffold Gererator on Bootstrap Style
  * Use SimpleForm for CRUD generator on Bootstrap Style
  * Use Kaminari for Pagination on Bootstrap Style
  * Compatible with Rails 3.2


## Changelog
  * Released gem v.0.0.1


## Future
  * Writing tests (not implemented yet)
  * Markup Helpers for Twitter Bootstrap like: (alert, tabs, pagination, breadcrumbs etc.)
  * Layout for Admin Layout (WORKING ON)
  * Helpers and Generators Compatibles with NAMESPACES on Rails(WORKING ON)


## Credits
Allan Freitas - allanfreitasci [at] gmail com

 * [My Twitter](http://twitter.com/allanfreitas "My Twitter")
 * [My Linkedin](http://linkedin.com/in/allanfreitas "My Linkedin")
 * [My Facebook](https://www.facebook.com/allanfreitasci "My Facebook")
 * [My Google+](http://plus.ly/allanfreitas "My Google+")
 * [Visit My Blog](http://www.allanfreitas.com.br/ "Visit My Blog")


## Thanks
Twitter Bootstrap and all Railstrap contributors
http://twitter.github.com/bootstrap

## Copyright
Copyright © 2012 Allan Freitas. See MIT-LICENSE for more details.