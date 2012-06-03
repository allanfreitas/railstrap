#layout_generator.rb
# adicionar isso à meu template de layout
# <title><%= options.app_name %></title>
# <%%= stylesheet_link_tag "web_app_theme" %>
#

module Railstrap
  class LayoutGenerator < Rails::Generators::Base
    
    #argument :nested, :type => :string, :required => true
    #argument :campos, :type => :array, :required => true
    class_option :name,         :type => :string,   :default => 'railstrap_admin', :desc => 'Specify the template engine'
  
    source_root File.expand_path('../templates', __FILE__)
    
    def initialize(args, *options)
      
      super(args, *options)
      initialize_views_variables
    end
    
    def generate_lookup
      template "layout_railstrap.html.erb", File.join('app/views/layouts', "#{options.name.singularize.underscore}.html.erb")
    end

    def copy_assets
      copy_file '', File.join('app/views', @controller_file_path, "index.html.#{options.engine}")
    end
    
  protected
    
    def initialize_views_variables
      @controller_file_path = extract_modules(name)
    end
    
    def extract_modules(name)
      modules = name.include?('/') ? name.split('/') : name.split('::')
      name    = modules.pop
      path    = modules.map { |m| m.underscore }
      file_path = (path + [name.underscore]).join('/')

      file_path
    end

  end
end

module Railstrap
  class LayoutGenerator < Rails::Generators::Base
    desc "Instala um Layout para Administração e cria o arquivo railstrap_painel.css.scss"
    source_root File.expand_path('../templates', __FILE__)
    
    argument :layout_name, :type => :string, :default => 'application'
    
    #class_option :theme,        :type => :string,   :default => :default,   :desc => 'Specify the layout theme'
    class_option :app_name,     :type => :string,   :default => 'Railstrap Painel',  :desc => 'Specify the application name'
    #class_option :engine,       :type => :string,   :default => 'erb',      :desc => 'Specify the template engine'
    class_option :no_layout,    :type => :boolean,  :default => false,      :desc => 'Use this option if you want to generate only stylesheets'
    class_option :no_assets,    :type => :boolean,  :default => false,      :desc => 'Use this option if you want to generate only the Layout File'
    class_option :layout_type,  :type => :string,   :default => 'admin',    :desc => 'Layout type, admin or sign'
    
    def copy_layout
      return if options.no_layout
      admin_layout_name = options.layout_type == 'sign' ? "layout_sign.html.erb" : "layout_admin.html.erb"
      #case options.engine
      #when 'erb'
        template  admin_layout_name, "app/views/layouts/#{layout_name.underscore}.html.erb"
      #when 'haml'
      #  generate_haml_layout(admin_layout_name)        
      #end                  
    end

    #def copy_assets
    #  copy_file '', File.join('app/views', @controller_file_path, "index.html.#{options.engine}")
    #end
    
    def copy_theme_stylesheet 
      template "railstrap_painel.css.scss.erb", "app/assets/stylesheets/railstrap_painel.css.scss"
    end

    def copy_theme_javascript 
      template "railstrap_painel.js.erb", "app/assets/stylesheets/railstrap_painel.js"
    end  

  end
end