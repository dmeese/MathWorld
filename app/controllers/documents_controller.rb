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

#This shows only public content to non-logged inusers

    if (@loggedinuser && @loggedinuser.authorizationlevel >= 1 ) || @document.authorizationlevel == 1 
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
  def search
    # This would be the logic of the search function
  end


  # GET /documents/new
  # GET /documents/new.json
  def new

#Make sure only logged in users can manipulate content

    if @loggedinuser && @loggedinuser.authorizationlevel >= 3
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

#Make sure only logged in users can manipulate content

    if @loggedinuser && @loggedinuser.authorizationlevel >= 3
      @document = Document.find(params[:id])
    else
       redirect_to '/'
    end
  end

  # POST /documents
  # POST /documents.json
  def create

#Make sure only logged in users can manipulate content

    if @loggedinuser && @loggedinuser.authorizationlevel >= 3
      @document = Document.new(params[:document])
      @document.owner = @loggedinuser.username
  
      respond_to do |format|
        if @document.save
          @history = DocumentHistory.create(:change_type => "CREATE", 
                                            :document_name => @document.filename, 
                                            :document_id => @document.id,
                                            :user_id => @document.user_id,
                                            :user_name => @document.owner)
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

#Make sure only logged in users can manipulate content

    if @loggedinuser && @loggedinuser.authorizationlevel >= 2
      @document = Document.find(params[:id])

      respond_to do |format|
        if @document.update_attributes(params[:document])
          @history = DocumentHistory.create(:change_type => "MODIFY", 
                                            :document_name => @document.filename, 
                                            :document_id => @document.id,
                                            :user_id => @document.user_id,
                                            :user_name => @document.owner)
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

#Make sure only logged in users can manipulate content

    if @loggedinuser && @loggedinuser.authorizationlevel >= 3
      @document = Document.find(params[:id])
      @document.destroy
      @history = DocumentHistory.create(:change_type => "DELETE", 
                                        :document_name => @document.filename, 
                                        :document_id => @document.id,
                                        :user_id => @document.user_id,
                                        :user_name => @document.owner)

      respond_to do |format|
        format.html { redirect_to documents_url }
        format.json { head :no_content }
      end
    else
       redirect_to '/'
    end
  end
end
