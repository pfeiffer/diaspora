class RequestsController < ApplicationController
  before_filter :authenticate_user!
  include RequestsHelper 
  def index
    @local_person_requests = Request.from_user( User.first )
    @remote_person_requests = Request.for_user( User.first )

    @person_request = Request.new
  end
  
  def destroy
    @person_request = Request.where(:id => params[:id]).first
    @person_request.destroy
    flash[:notice] = "Successfully destroyed person request."
    redirect_to person_requests_url
  end
  
  def new
    @person_request = Request.new
  end
  
  def create
    @person_request = Request.send_request_to params[:person_request][:destination_url]

    if @person_request
      flash[:notice] = "Successfully created person request."
      redirect_to person_requests_url
    else
      render :action => 'new'
    end
  end


end