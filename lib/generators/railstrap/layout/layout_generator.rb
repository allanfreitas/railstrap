#layout_generator.rb
module Railstrap
  class LayoutGenerator < Rails::Generators::Base
    desc "Instala um Layout para Administração e cria o arquivo railstrap_painel.css.scss"
    source_root File.expand_path('../templates', __FILE__)
    
    argument :layout_name, :type => :string, :default => 'application'
    
    #class_option :theme,        :type => :string,   :default => :default,   :desc => 'Specify the layout theme'
    #class_option :engine,       :type => :string,   :default => 'erb',      :desc => 'Specify the template engine'
    class_option :app_name,     :type => :string,   :default => 'Railstrap Painel',  :desc => 'Specify the application name'
    class_option :no_layout,    :type => :boolean,  :default => false,      :desc => 'Use this option if you want to generate only stylesheets'
    class_option :no_assets,    :type => :boolean,  :default => false,      :desc => 'Use this option if you want to generate only the Layout File'
    class_option :layout_type,  :type => :string,   :default => 'admin',    :desc => 'Layout type, admin or sign'
    
    def copy_layout
      return if options.no_layout
      admin_layout_name = options.layout_type == 'sign' ? "layout_railstrap_sign.html.erb" : "layout_railstrap.html.erb"

      template  admin_layout_name, "app/views/layouts/#{layout_name.underscore}.html.erb"
    end

    def copy_assets
      return if options.no_assets
      template "railstrap_painel.css.scss.erb", "app/assets/stylesheets/railstrap_painel.css.scss"
      template "railstrap_painel.js.erb", "app/assets/javascripts/railstrap_painel.js"
    end

  end
end