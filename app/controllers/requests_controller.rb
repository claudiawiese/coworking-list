class RequestsController < ApplicationController

  def index
    @requests = Request.all
    @counter = 0
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
    if @request.update(status: 'confirmed')
      flash[:notice] = "Thanks for your email confirmation"
      ClientMailer.confirmation_three_months(@request).deliver_later(wait_until: 3.months.from_now)
      StatusUpdateJob.set(wait_until: (3.minutes.from_now)).perform_later(@request.id)
      redirect_to request_path(@request)
    else
      redirect_to request_path(@request)
    end
  end

  def confirm_three_months
    @request = Request.find(params[:id])
    list
    if @request.status == 'confirmed'
      if @request.update(status: 'confirmed')
        flash[:notice] = "Thanks for having reconfirmed your subscription"
        ClientMailer.confirmation_three_months(@request).deliver_later(wait_until: (3.months.from_now))
        StatusUpdateJob.set(wait_until: (3.months.from_now + 15.days)).perform_later(@request.id)
        redirect_to request_path(@request)
      else
        redirect_to request_path
      end
    end
    if @request.status == 'expired'
      flash[:notice] = "Sorry your subscription has expired, please subscribe again"
      redirect_to new_request_path
    end
  end

  private

  def request_params
    params.require(:request).permit(:client_first_name, :client_last_name, :email, :phone, :bio, :date, :status)
  end

  def list
  @counter = 1
    if @request.status == "confirmed"
      @list = Request.confirmed.pluck(:id)
    elsif @request.status == "accepted"
      if @list != nil
        @list.delete_at(@list.index(@request.id))
      end
    elsif @request.status == "expired"
      if @list != nil
        @list.delete_at(@list.index(@request.id))
      end
    end
  end
end
