module Railstrap
  class Engine < ::Rails::Engine

    initializer 'railstrap.active_record_extensions' do |app|
      #require 'active_record_extensions.rb'
      ActiveSupport.on_load(:active_record) do
        extend Railstrap::ActiveRecord::Search::ClassMethods
        #include Railstrap::InstanceMethods
      end
    end

    initializer 'railstrap.active_controller_extensions' do |app|
      ActiveSupport.on_load(:action_controller) do
        #extend Railstrap::ActionController::ClassMethods
        #include Railstrap::ActionController::InstanceMethods
        include Railstrap::ActionController
      end
        #ActionController::Base.send(:include, Railstrap::Controller)
    end

    initializer 'railstrap.active_view_extensions' do |app|
    	ActiveSupport.on_load :action_view do
  			include ::Sprockets::Helpers::RailsHelper
		  end
    end	


  end
end
