
class Painel::AuthorsController < ApplicationController
  # GET /painel/authors
  # GET /painel/authors.json
  def index
    @authors = Author.tb_search(:search => {:text => params[:search],:fields => ['id']}, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @authors }
    end
  end

  # GET /painel/authors/1
  # GET /painel/authors/1.json
  def show
    @author = Author.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @author }
    end
  end

  # GET /painel/authors/new
  # GET /painel/authors/new.json
  def new
    @author = Author.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @author }
    end
  end

  # GET /painel/authors/1/edit
  def edit
    @author = Author.find(params[:id])
  end

  # POST /painel/authors
  # POST /painel/authors.json
  def create
    @author = Author.new(params[:author])

    respond_to do |format|
      if @author.save
        format.html { redirect_to painel_author_path(@author), :notice => 'Author was successfully created.' }
        format.json { render :json => @author, :status => :created, :location => @author }
      else
        format.html { render :action => "new" }
        format.json { render :json => @author.errors , :status => :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /painel/authors/1
  # PATCH/PUT /painel/authors/1.json
  def update
    @author = Author.find(params[:id])

    respond_to do |format|
      if @author.update_attributes(params[:author])
        format.html { redirect_to painel_author_path(@author), :notice => 'Author was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @author.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /painel/authors/1
  # DELETE /painel/authors/1.json
  def destroy
    @author = Author.find(params[:id])
    @author.destroy

    respond_to do |format|
      format.html { redirect_to painel_authors_index_url }
      format.json { head :ok }
    end
  end
end
