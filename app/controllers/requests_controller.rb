class RequestsController < ApplicationController

  def index
    @requests = Request.all
    @counter = 0
  end

  def show
    @request = Request.find(params[:id])
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    @request.status = "unconfirmed"
    if @request.save
      ClientMailer.confirmation_email(@request).deliver_now
      ClientMailer.confirmation_three_months(@request).deliver_later(wait_until: 3.months.from_now)
      redirect_to requests_path
    else
      render :new
    end
  end

  def confirm
    @request = Request.find(params[:id])
    if @request.update(status: 'confirmed')
      flash[:notice] = "Thanks for your email confirmation"
      #StatusUpdateJob.set(wait_until: 3.months.from_now).perform_later(@request.id)
      redirect_to requests_path
    else
      redirect_to requests_path
    end
  end

  def confirm_three_months
    @request = Request.find(params[:id])
    if @request.status == 'confirmed'
      if @request.update(status: 'confirmed')
        flash[:notice] = "Thanks for having reconfirmed your subscription"
        ClientMailer.confirmation_three_months(@request).deliver_later(wait_until: (3.months.from_now + 15.days))
        redirect_to requests_path
      else
        redirect_to requests_path
      end
    end
    if @request.status == 'expired'
        flash[:notice] = "Sorry your subscription has expired"
        redirect_to requests_path
    end
  end

  private

  def request_params
    params.require(:request).permit(:client_first_name, :client_last_name, :email, :phone, :bio, :date, :status)
  end

end
