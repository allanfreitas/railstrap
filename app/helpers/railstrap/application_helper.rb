module Railstrap
	module ApplicationHelper


		##### HELPERS PARA TABLE #############

    #TABLE
    def tb_table_for(collection, *args, &proc)
      options = args.extract_options!
      options[:html]={:class=>'table table-striped table-bordered table-condensed'}
      table_for collection, options do |t|
        if options[:actions].present? && options[:actions].count > 0
          t.column :title=>"",:html => { :th => { :width => ((options[:actions].count.to_i*21)).to_s }, :td=>{:class=>"btn_actions"}} do |resource|
            options[:actions].each do |action|
              p resource.class
              if [:show,:edit,:delete].include? action
                concat(send("table_btn_#{action}",resource))
              elsif [:select].include? action
                concat(send("table_btn_show",resource,params[:fill]))
              else
                concat(send("#{action}",resource))
              end
            end
          end
        end
        begin
          t.instance_eval(&proc)
        rescue
          concat("")
        end
      end
    end


    #BOTAO GENERICO
    def table_button_generic(button,icon,path,*args)
      options = args.extract_options!

      options[:class] = "btn btn-smallest btn-"+button

      #concat(link_to content_tag("i", "",:class=>"icon-"+icon+" icon-white"), path, options)
      link_to content_tag("i", "",:class=>"icon-"+icon+" icon-white"), path, options
    end


    def table_btn_show(model, *args)
      options = args.extract_options!

      model_name = model.class.to_s.underscore

      name_space_controller = ''
      if !@namespace.nil?
        name_space_controller << @namespace << '_'
      end

      table_button_generic('info', 'search', send("#{name_space_controller}#{model_name}_path",model), options)
    end

    def table_btn_edit(model, *args)
      model_name = model.class.to_s.underscore

      options = args.extract_options!

      name_space_controller = ''
      if !@namespace.nil?
        name_space_controller << @namespace << '_'
      end

      table_button_generic('warning', 'pencil', send("edit_#{name_space_controller}#{model_name}_path",model), options)
    end


    def table_btn_delete(model, *args)
      options = args.extract_options!

      model_name = model.class.to_s.underscore

      options[:confirm] = 'Deletar! Você tem certeza?'
      options[:method] = :delete

      name_space_controller = ''
      if !@namespace.nil?
        name_space_controller << @namespace << '_'
      end

      table_button_generic('danger', 'minus', send("#{name_space_controller}#{model_name}_path",model), options)
    end
		#####################################

	    #
	    def tb_fixed_toolbar(title="",path="",&block)
	        #content_tag :header,:class=>"jumbotron subhead" do
	            content_tag :div, :class=>"subnav subnav-fixed" do
	              content_tag :div, :class => "container" do
	                content_tag :ul,:class=>"nav nav-pills", :id=>"overview" do
	                  concat(tb_page_title(title, path))  
	                  block.call  
	                end  
	              end
	            end
	        #end
	    end

	    #TOP BAR HELPERS
	    def tb_page_title(title, path)
	      content_tag :li do
	        link_to(content_tag("b", title), path)
	      end
	    end
    #
    def tb_search_tool(class_ref, nested_path = nil)
      class_name = class_ref.name.to_s.underscore
      
      name_space_controller = ''
      if !@namespace.nil?
        name_space_controller << @namespace << '_'
      end

      if nested_path.nil?
        meu_path = send("#{name_space_controller}#{class_name.pluralize}_path")   
      else
        nested_path = nested_path.name.to_s.underscore
        
        meu_path = send("#{name_space_controller}#{nested_path}_#{class_name.pluralize}_path")
      end
      
      content_tag :li do
        form_tag(meu_path, :method=>"get", :id=>"formsearch", :style=>"padding-top:4px;padding-left:10px;",:class=>"form-search form-search-top") do
          #concat(hidden_field_tag :fill, params[:fill])
          concat(text_field_tag :search, params[:search], :class=>"input-medium search-query")
          concat(content_tag("button",:type=>"submit",:class=>"btn btn-info",:style=>"margin-left:4px;",:id=>"btn-search") do
            content_tag("i", "",:class=>"icon-search icon-white")
          end)
        end
      end
    end

    def tb_add_button_to(model, nested_path = nil)
      model_name = model.name.to_s.underscore

      name_space_controller = ''
      if !@namespace.nil?
        name_space_controller << @namespace << '_'
      end


      if nested_path.nil?
        nested_path = ''
      else
        nested_path = nested_path.name.to_s.underscore << '_'
      end

      content_tag :li do
        link_to content_tag("i", "",:class=>"icon-plus")<<" Adicionar", send("new_#{name_space_controller}#{nested_path}#{model_name}_path"), :id=>"add"
      end
    end


    def tb_cancel_button_to(model)
      model_name = model.class.to_s.underscore

      name_space_controller = ''
      if !@namespace.nil?
        name_space_controller << @namespace << '_'
      end

      content_tag :li do
        link_to content_tag("i", "",:class=>"icon-backward")<<' Cancelar', send("#{name_space_controller}#{model_name.pluralize}_path"),:id=>"cancel"
      end
    end

    #BUUTTON_HELPERS
    def tb_edit_button_to(model)
      model_name = model.class.to_s.underscore

      name_space_controller = ''
      if !@namespace.nil?
        name_space_controller << @namespace << '_'
      end

      content_tag :li do
        link_to content_tag("i", "",:class=>"icon-pencil")<<' Editar', send("edit_#{name_space_controller}#{model_name}_path",model)
      end
    end
    
    
    #BUUTTON_HELPERS
    def tb_delete_button_to(model)

      model_name = model.class.to_s.underscore

      name_space_controller = ''
      if !@namespace.nil?
        name_space_controller << @namespace << '_'
      end

      content_tag :li do
        link_to content_tag("i", "",:class=>"icon-minus")<<' Excluir', send("#{name_space_controller}#{model_name}_path",model), :confirm => 'Deseja realmente excluir?', :method => :delete
      end
    end
    
    def tb_submit_button_to(model,text="Salvar")
      content_tag :li do
        tb_link_to_submit model, content_tag("i", "",:class=>"icon-ok")<<" "<<text,:id=>"submit"     
      end
    end

    def tb_link_to_submit(model, name, html_options={})
      class_name = model.class.to_s.underscore
        #link_to_function name, ";$(this).closest('form').submit()",html_options
        link_to_function name, ";$('form[id*=#{class_name}]').submit()",html_options
    end

    ### PAGINACAO
    def tb_paginate_navbar(resource,*args)
      options = args.extract_options!
      #options[:page_links] = true if options[:page_links].present?
      #options[:previous_label] = content_tag("i"," ",:class=>"icon-arrow-left")
      #options[:next_label] = content_tag("i"," ",:class=>"icon-arrow-right")
      new_options = options
      
      begin       
        flexa_wp = will_paginate resource, new_options 
      rescue
        ""
      end
      begin       
        flexa_wp["<ul>"]= "" 
      rescue
        ""
      end
      begin       
        flexa_wp["</ul>"]= ""  
      rescue
        ""
      end
      begin       
        flexa_wp['<div class="pagination">']= "" 
      rescue
        ""
      end
      begin       
        flexa_wp["</div>"]= "" 
      rescue
        ""
      end
      flexa_wp
    end

  def tb_boolean_grid(status)
    if status
      imagem = 'icon_sucess.gif'
    else
      imagem = 'icon_error.gif'
    end
    image_tag(imagem)
  end

	end
end
