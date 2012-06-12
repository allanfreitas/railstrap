#action_controller.rb

#require 'railstrap/action_controller'

module Railstrap
	module ActionController
		#module Base
		  def self.included(base)
		    base.send(:include, InstanceMethods) 
		    base.before_filter :tb_namespace
		    #base.after_filter :my_method_2
  		end

			module InstanceMethods
				  def tb_namespace
            		path = self.controller_path.split('/')
		            @namespace = path.second ? path.first : nil
  				end
			end

			module ClassMethods
				  #def tb_namespace
          #  		path = self.controller_path.split('/')
		      #      @namespace = path.second ? path.first : nil
  				#end
			end
		#end
	end
end