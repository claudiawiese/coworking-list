class RequestsController < ApplicationController
  def index
    @requests = Request.all
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    @request.status = "unconfirmed"
    if @request.save
      redirect_to requests_path
      ClientMailer.confirmation_email(@confirmation).deliver_now
    else
      render :new
    end
  end

  def delete
    @request = Request.find(params[:id])
    if @request.status = "unconfirmed"
  end

  def confirm
    @request = Request.find(params[:id])
    if @request.update(status: 'confirmed')
      flash[:notice] = "Thanks for your email confirmation"
      redirect_to requests_path
    else
      redirect_to requests_path
    end
  end

  private

  def request_params
    params.require(:request).permit(:client_first_name, :client_last_name, :email, :phone, :bio, :date, :status)
  end
end
