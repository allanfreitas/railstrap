#crud_generator.rb
module Railstrap
  class CrudGenerator < Rails::Generators::NamedBase

    source_root File.expand_path('../templates', __FILE__)

    #check_class_collision :suffix => "Controller" 

    #argument :controller_path,  :type => :string
    argument :name,             :type => :string
    argument :model_name,       :type => :string #, :required => false
    
    class_option :no_controller,  :type => :boolean,  :default => false, :desc => 'Sem controller'
    class_option :no_views,  :type => :boolean,  :default => false, :desc => 'Sem Views'

    #ADICIONAR SUPORTE A WILL_PAGINATE DEPOIS
    #class_option :will_paginate,  :type => :boolean,  :default => false, :desc => 'Specify if you use will_paginate'
  	class_option :kaminari,  :type => :boolean,  :default => false, :desc => 'Specify if you use Kaminari'

    class_option :themed_type,    :type => :string,   :default => 'crud', 
      :desc => 'Specify the themed type: crud, list or show. Default is crud'

    
    def initialize(args, *options)
      #p args.to_yaml
      
      super(args, *options)
      initialize_views_variables
    end
    

    def create_controller_files
      return if options.no_controller
      #if !options.no_controller
        template "controller.rb", File.join('app/controllers', "#{@controller_file_path}_controller.rb")
        route("resources :#{plural_resource_name}")
      #end
    end
    
    def copy_views
      generate_views
      #unless options.layout.blank?
        #if options.engine =~ /erb/
        #gsub_file(File.join('app/views/layouts', "#{options[:layout]}.html.#{options.engine}"), /\<div\s+id=\"main-navigation\">.*\<\/ul\>/mi) do |match|
        #  match.gsub!(/\<\/ul\>/, "")
        #  %|#{match} <li class="<%= controller.controller_path == '#{@controller_file_path}' ? 'active' : '' %>"><a href="<%= #{controller_routing_path}_path %>">#{plural_model_name}</a></li></ul>|
        #end
        #end
      #end
    end

  protected
    
    def initialize_views_variables
      #@base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(controller_path)
      @base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(name)
      @controller_routing_path = @controller_file_path.gsub(/\//, '_')
      @model_name = @base_name.singularize unless @model_name
      @model_name = @model_name.camelize

      #p "#################################"
      #p extract_modules(name)
      #p "#################################"
      #abort("PAREI")
    end
    
    def controller_routing_path
      @controller_routing_path
    end
    
    def singular_controller_routing_path
      @controller_routing_path.singularize
    end
    
    def model_name
      @model_name
    end
    
    def plural_model_name
      @model_name.pluralize
    end
    
    def resource_name
      @model_name.underscore
    end
    
    def plural_resource_name
      resource_name.pluralize
    end

    #
    def namespace_path
      if @controller_class_nesting_depth == 0
        ''
      else
        @controller_class_nesting.downcase+'_'
      end
    end
    
    ## 
    # Attempts to call #columns on the model's class
    # If the (Active Record) #columns method does not exist, it attempts to
    # perform the (Mongoid) #fields method instead
    def columns
      begin
        excluded_column_names = %w[id created_at updated_at]
        Kernel.const_get(@model_name).columns.reject{|c| excluded_column_names.include?(c.name) }.collect{|c| Rails::Generators::GeneratedAttribute.new(c.name, c.type)} 
      rescue NoMethodError
        Kernel.const_get(@model_name).fields.collect{|c| c[1]}.reject{|c| excluded_column_names.include?(c.name) }.collect{|c| Rails::Generators::GeneratedAttribute.new(c.name, c.type.to_s)}
      end
    end
    
    def extract_modules(name)
      modules = name.include?('/') ? name.split('/') : name.split('::')
      name    = modules.pop
      path    = modules.map { |m| m.underscore }
      file_path = (path + [name.underscore]).join('/')
      nesting = modules.map { |m| m.camelize }.join('::')
      [name, path, file_path, nesting, modules.size]
    end
    
    def generate_views
      return if options.no_views
      
      views = {
        'crud' => {
          'view_index.html.erb'  => File.join('app/views', @controller_file_path, "index.html.erb"),
          'view_new.html.erb'     => File.join('app/views', @controller_file_path, "new.html.erb"),
          'view_edit.html.erb'    => File.join('app/views', @controller_file_path, "edit.html.erb"),
          'view_form.html.erb'    => File.join('app/views', @controller_file_path, "_form.html.erb"),
          'view_show.html.erb'    => File.join('app/views', @controller_file_path, "show.html.erb")
        },
	      'list' => {
	        'view_index.html.erb'  => File.join('app/views', @controller_file_path, "index.html.erb")
	      },
        'show' => {
          'view_show.html.erb'    => File.join('app/views', @controller_file_path, "show.html.erb")
          #'view_sidebar.html.erb' => File.join('app/views', @controller_file_path, "_sidebar.html.#{options.engine}")
        }
      }
      selected_views = views[options.themed_type]
      options.engine == 'haml' ? generate_haml_views(selected_views) : generate_erb_views(selected_views)
    end
    
    def generate_erb_views(views)
      views.each do |template_name, output_path|
        template template_name, output_path
      end
    end


  end#fim da class CrudGenerator
end#fim do modulo Railstrap