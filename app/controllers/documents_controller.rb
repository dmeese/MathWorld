class DocumentsController < ApplicationController
  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])

    if (@loggedinuser && @loggedinuser.AuthorizationLevel >= 1 ) || @document.AuthorizationLevel == 1 
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @document }
      end
    else
       redirect_to '/'
    end
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
    if @loggedinuser && @loggedinuser.AuthorizationLevel >= 3
       @document = Document.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @document }
      end
    else
       redirect_to '/'
    end
  end

  # GET /documents/1/edit
  def edit
    if @loggedinuser && @loggedinuser.AuthorizationLevel >= 3
      @document = Document.find(params[:id])
    else
       redirect_to '/'
    end
  end

  # POST /documents
  # POST /documents.json
  def create
    if @loggedinuser && @loggedinuser.AuthorizationLevel >= 3
      @document = Document.new(params[:document])
      @document.Owner = @loggedinuser.UserName
  
      respond_to do |format|
        if @document.save
          format.html { redirect_to @document, notice: 'Document was successfully created.' }
          format.json { render json: @document, status: :created, location: @document }
        else
          format.html { render action: "new" }
          format.json { render json: @document.errors, status: :unprocessable_entity }
        end
      end
    else
       redirect_to '/'
    end
  end

  # PUT /documents/1
  # PUT /documents/1.json
  def update
    if @loggedinuser && @loggedinuser.AuthorizationLevel >= 3
      @document = Document.find(params[:id])

      respond_to do |format|
        if @document.update_attributes(params[:document])
          format.html { redirect_to @document, notice: 'Document was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @document.errors, status: :unprocessable_entity }
        end
      end
    else
       redirect_to '/'
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    if @loggedinuser && @loggedinuser.AuthorizationLevel >= 3
      @document = Document.find(params[:id])
      @document.destroy

      respond_to do |format|
        format.html { redirect_to documents_url }
        format.json { head :no_content }
      end
    else
       redirect_to '/'
    end
  end
end
