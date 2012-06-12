#active_record
module Railstrap
	module ActiveRecord
	  module Search
	    #def self.included(base)
	    #  base.extend(ClassMethods)
	    #end

	    # add your instance methods here
	    #def foo
	    #   "foo"
	    #end

	    module ClassMethods
	      # add your static(class) methods here
	      #def bar
	      #  "bar"
	      #end
	            #
	      # tb_search BUSCA
	      #
	      #   Model.tb_search(:search => {:text => params[:search], 
	      #    :fields => ['nome','cod_cidade']}, :page => params[:page])
	      #
	      def tb_search(options)
	        options  = options.dup
	        
	        search_options = options.fetch(:search)        { raise ArgumentError, ":search is required" }
	        likes_search   = search_options.fetch(:fields) { raise ArgumentError, ":fields is required" }
	        text_search   = search_options.fetch(:text)   { raise ArgumentError, ":text is required" }
	        
	        page = options.fetch(:page)   { raise ArgumentError, ":page is required" }

	        text_search ||= ''
	        
	        options.delete(:search)
	        
	        if text_search.length > 0 and likes_search.count > 0
	          
	          likes_search.collect! {|x| "(UPPER("+x+") LIKE UPPER(:search))"}
	          page(page).where(likes_search.join(' OR '), :search => "%"+text_search.to_s+"%")
	        else
	          page(page)
	        end
	        #trocar o "page" por "paginate" caso esteja usando o Will_paginate
	      end
	   end
	  end#fim do search
	end
end
	#
	#ActiveRecord::Base.send(:include, SageActiveRecordExtensions)