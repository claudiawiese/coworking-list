class RequestsController < ApplicationController
  def index
    @requests = Request.all
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    if @request.save
      redirect_to requests_path
    else
      render :new
    end
  end

  def delete
  end
end

private

def request_params
  params.require(:request).permit(:client_first_name, :client_last_name, :email, :phone, :bio, :date)
end
