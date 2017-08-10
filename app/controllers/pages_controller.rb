class PagesController < ApplicationController

  layout 'admin'

  #Show
  def index
    #Finds all the pages by the sorted scope
    @pages = Page.sorted
  end

  def show
    #Finds the detailed view for a single page
    @page = Page.find(params[:id])
  end

  #Create
  def new
    #Instantiates a new page with defaults from our database
    @page = Page.new(:name => "New Page")
    @page_count = Page.count + 1
    @subjects = Subject.sorted
  end

  def create
    #Instantiates a new page with the params filled out on the form
    @page = Page.new(page_params)
    if @page.save
      #If the save succeeds then we display a message
      flash[:notice] = "Page created successfully"
      redirect_to(pages_path)
    else
      @page_count = Page.count + 1
      @subjects = Subject.sorted
      render('new')
    end
  end

  #Update
  def edit
    #Find a the page in the database and display information aboout it
    @page = Page.find(params[:id])
    @page_count = Page.count
    @subjects = Subject.sorted
  end

  def update
    #When that form is submitted with changes update will process the changes
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Page updated successfully"
      redirect_to(page_path(@page))
    else
      @page_count = Page.count
      @subjects = Subject.sorted
      render('edit')
    end
  end

  #Destroy
  def delete
    #Finds a records so we confirm that the user does want to destroy it
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Page destroyed successfully"
    redirect_to(pages_path)
  end

  private

  def page_params
    params.require(:page).permit(:subject_id, :name, :position, :visible, :permalink)
  end
end
