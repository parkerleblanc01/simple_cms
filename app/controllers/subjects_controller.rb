class SubjectsController < ApplicationController
  layout 'admin'

  #Reading
  def index
    @subjects = Subject.sorted

    
  end

  def show
    @subject = Subject.find(params[:id])
  end

  #Creating
  def new
    #This will give default values specified in our models in our form, we can add default
    #values like name done below
    @subject = Subject.new({:name => 'Default'})
    @subject_count = Subject.count + 1
  end

  def create
    #Instantiate a new object using form parameters
    @subject = Subject.new(subject_params)
    #Save the object
    if @subject.save
    #If Save succeeds, redirect to the index action
    flash[:notice] = "Subject created successfully."
    redirect_to(subjects_path)
    else
    #If the save fails, redisplay the form so user can fix problems
    @subject_count = Subject.count + 1
    render('new')
    end
  end

  #Updating
  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end

  def update
    #Instantiate a new object using form parameters
    @subject = Subject.find(params[:id])
    #Save the object
    if @subject.update_attributes(subject_params)
    #If Save succeeds, redirect to the show action
    flash[:notice] = "Subject updated successfully."
    redirect_to(subject_path(@subject))
    else
    #If the save fails, redisplay the form so user can fix problems
    @subject_count = Subject.count
    render('edit')
    end
  end

  #Deleting
  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    flash[:notice] = "Subject '#{@subject.name}' deleted successfully."
    redirect_to(subjects_path)
  end

  def subject_params
    params.require(:subject).permit(:name, :position, :visible, :created_at)
  end
end
