class SectionsController < ApplicationController

  layout 'admin'

  #Show
  def index
    @sections = Section.sorted
  end

  def show
    @section = find_section
  end

  #Create
  def new
    @section = Section.new
    @section_count = Section.count + 1
    @pages = Page.sorted
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = "Section created successfully"
      redirect_to(sections_path)
    else
      @section_count = Section.count + 1
      @pages = Page.sorted
      render('new')
    end
  end

  #Update
  def edit
    @section_count = Section.count
    @pages = Page.sorted
    @section = find_section
  end

  def update
    @section = find_section
    if @section.update_attributes(section_params)
      flash[:notice] = "Section updated successfully"
      redirect_to(section_path(@section))
    else
      @section_count = Section.count
      @pages = Page.sorted
      render('edit')
    end
  end

  #Destroy
  def delete
    @section = find_section
  end

  def destroy
    @section = find_section
    @section.destroy
    flash[:notice] = "Section destroyed successfully"
    redirect_to(sections_path)
  end

  private

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end

  def find_section
    Section.find(params[:id])
  end
end
