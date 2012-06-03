<% module_namespacing do -%>
<%
  model_nome = class_name.split('::')
  controller_class_name = class_name
if model_nome.count > 1

  ptbl_nome = plural_table_name.split('_')
  tbl_nome = singular_table_name.split('_')
  #
  model_nome.shift
  
  #model_nome
  #
  ptbl_nome.shift
  ptbl_nome = ptbl_nome.join('_')
  #
  tbl_nome.shift
  tbl_nome = tbl_nome.join('_')

else
  model_nome = class_name
  ptbl_nome  = plural_table_name
  tbl_nome   = singular_table_name 
end
%>
class <%= controller_class_name %>Controller < ApplicationController
  # GET <%= route_url %>
  # GET <%= route_url %>.json
  def index
    @<%= ptbl_nome %> = <%= tbl_nome.camelcase %>.tb_search(:search => {:text => params[:search],:fields => ['id']}, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => <%= "@#{ptbl_nome}" %> }
    end
  end

  # GET <%= route_url %>/1
  # GET <%= route_url %>/1.json
  def show
    @<%= tbl_nome %> = <%= tbl_nome.camelcase %>.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => <%= "@#{tbl_nome}" %> }
    end
  end

  # GET <%= route_url %>/new
  # GET <%= route_url %>/new.json
  def new
    @<%= tbl_nome %> = <%= tbl_nome.camelcase %>.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => <%= "@#{tbl_nome}" %> }
    end
  end

  # GET <%= route_url %>/1/edit
  def edit
    @<%= tbl_nome %> = <%= tbl_nome.camelcase %>.find(params[:id])
  end

  # POST <%= route_url %>
  # POST <%= route_url %>.json
  def create
    @<%= tbl_nome %> = <%= tbl_nome.camelcase %>.new(params[:<%= tbl_nome %>])

    respond_to do |format|
      if @<%= tbl_nome %>.save
        format.html { redirect_to @<%= tbl_nome %>, :notice => <%= "'#{tbl_nome.camelcase} was successfully created.'" %> }
        format.json { render :json => <%= "@#{tbl_nome}" %>, :status => :created, :location => <%= "@#{tbl_nome}" %> }
      else
        format.html { render :action => "new" }
        format.json { render :json => <%= "@#{tbl_nome}" %>.errors , :status => :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT <%= route_url %>/1
  # PATCH/PUT <%= route_url %>/1.json
  def update
    @<%= tbl_nome %> = <%= tbl_nome.camelcase %>.find(params[:id])

    respond_to do |format|
      if @<%= tbl_nome%>.update_attributes(params[:<%=tbl_nome%>])
        format.html { redirect_to @<%= tbl_nome %>, :notice => <%= "'#{tbl_nome.camelcase} was successfully updated.'" %> }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => <%= "@#{tbl_nome}" %>.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE <%= route_url %>/1
  # DELETE <%= route_url %>/1.json
  def destroy
    @<%= tbl_nome %> = <%= tbl_nome.camelcase %>.find(params[:id])
    @<%= tbl_nome%>.destroy

    respond_to do |format|
      format.html { redirect_to <%= index_helper %>_url }
      format.json { head :ok }
    end
  end
end
<% end -%>