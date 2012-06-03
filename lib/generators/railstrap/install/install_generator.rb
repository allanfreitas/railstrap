#install_generator.rb
# adicionar isso à meu template de layout
# <title><%= options.app_name %></title>
# <%%= stylesheet_link_tag "web_app_theme" %>
#

module Railstrap
  class InstallGenerator < Rails::Generators::Base
    
    argument :nested, :type => :string, :required => true
    argument :campos, :type => :array, :required => true
  
    source_root File.expand_path('../templates', __FILE__)
    
    def initialize(args, *options)
      
      super(args, *options)
      initialize_views_variables
    end
    
    def generate_lookup
      template "layout_railstrap.html.erb", File.join('app/views/layouts', "#{nested.singularize.underscore}.html.erb")
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
  class ThemeGenerator < Rails::Generators::Base
    desc "Instala um Layout para Administração e cria o arquivo railstrap_painel.css.scss"
    source_root File.expand_path('../templates', __FILE__)
    
    argument :layout_name, :type => :string, :default => 'application'
    
    #class_option :theme,        :type => :string,   :default => :default,   :desc => 'Specify the layout theme'
    class_option :app_name,     :type => :string,   :default => 'Railstrap Painel',  :desc => 'Specify the application name'
    #class_option :engine,       :type => :string,   :default => 'erb',      :desc => 'Specify the template engine'
    class_option :no_layout,    :type => :boolean,  :default => false,      :desc => 'Use this option if you want to generate only stylesheets'
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
    
    def copy_theme_stylesheet 
      template "railstrap_painel.css.scss.erb", "app/assets/stylesheets/railstrap_painel.css.scss"
    end

  

  end
end