class PeopleController < ApplicationController
  before_action :find_person, only: %i[show update destroy]

  def create
    @person = Person.new(person_params)
    @person.photo_url =
      if params[:person][:photo_url].is_a? ActionDispatch::Http::UploadedFile
        params[:person][:photo_url].path
      else
        ''
      end
    @person.save
    render :show
  end

  def show
  end

  def update
    @person.assign_attributes person_params
    if params[:person][:photo_url].is_a? ActionDispatch::Http::UploadedFile
      @person.photo_url = params[:person][:photo_url].path
    end
    @person.save
    render :show
  end

  def destroy
    @person.destroy
  end

  protected

  def person_params
    params.require(:person).permit(:full_name, :status)
  end

  def find_person
    @person ||= Person.find(params[:id])
  end
end
