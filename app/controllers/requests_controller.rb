class RequestsController < ApplicationController

  def index
    @requests = Request.all
    @counter = 1
    @list = list
  end

  def show
    @request = Request.find(params[:id])
    list
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    @request.status = "unconfirmed"
    if @request.save
      flash[:notice] = "Thanks for your interest, you will shortly receive an email to confirm your subscription"
      ClientMailer.confirmation_email(@request).deliver_now
      redirect_to request_path(@request)
    else
      render :new
    end
  end

  def confirm
    @request = Request.find(params[:id])
    @request.update(date: Time.now)
    if @request.update(status: 'confirmed')
      flash[:notice] = "Thanks for your email confirmation"
      ClientMailer.confirmation_three_months(@request).deliver_later(wait_until: 3.months.from_now)
      StatusUpdateJob.set(wait_until: 3.months.from_now + 5.days).perform_later(@request.id)
      raise
      redirect_to request_path(@request)
    end
  end

  def confirm_three_months
    @request = Request.find(params[:id])
    if @request.status == 'confirmed'
      if @request.update(status_two: 'reconfirmed')
        flash[:notice] = "Thanks for having reconfirmed your subscription"
        StatusTwoJob.set(wait_until: 2.months.from_now).perform_later(@request.id)
        ClientMailer.confirmation_three_months(@request).deliver_later(wait_until: 3.months.from_now)
        StatusUpdateJob.set(wait_until: (3.months.from_now + 5.days)).perform_later(@request.id)
      end
        redirect_to request_path(@request)
    end
    if @request.status == 'expired'
      flash[:notice] = "Sorry your subscription has expired, please subscribe again"
      redirect_to new_request_path
    end
  end

  private

  def request_params
    params.require(:request).permit(:client_first_name, :client_last_name, :email, :phone, :bio, :date, :status, :photo)
  end

  def list
    @counter = 1
    @requests_confirmed = Request.confirmed.pluck(:id)
    @list = @requests_confirmed.sort.each {|request| Request.find(request).date}
  end
end
