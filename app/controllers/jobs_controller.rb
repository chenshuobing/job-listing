class JobsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :update, :edit, :destroy]
  def show
    @job = Job.find(params[:id])
    if @job.is_hidden
      flash[:warning] = "This job already archieved"
      redirect_to root_path
    end
  end
  def index
    # @jobs = Job.all
    # @jobs = Job.published.order("created_at DESC")
    @jobs = case params[:order]
            when 'by_lower_bound'
                Job.published.order('wage_lower_bound DESC')
            when 'by_upper_bound'
                Job.published.order('wage_upper_bound DESC')
            else
                Job.published.recent
            end
  end

  def internet_electronic_commerce
    # @jobs = Job.all
    # @jobs = Job.published.order("created_at DESC")
    @jobs = case params[:order]
            when 'by_lower_bound'
                Job.published.where(:category => "internet_electronic_commerce").order('wage_lower_bound DESC')
            when 'by_upper_bound'
                Job.published.where(:category => "internet_electronic_commerce").order('wage_upper_bound DESC')
            else
                Job.published.where(:category => "internet_electronic_commerce").recent
            end
  end

  def finace_investment_security
    # @jobs = Job.all
    # @jobs = Job.published.order("created_at DESC")
    @jobs = case params[:order]
            when 'by_lower_bound'
                Job.published.where(:category => "finace_investment_security").order('wage_lower_bound DESC')
            when 'by_upper_bound'
                Job.published.where(:category => "finace_investment_security").order('wage_upper_bound DESC')
            else
                Job.published.where(:category => "finace_investment_security").recent
            end
  end

  def cars_auto_parts
    # @jobs = Job.all
    # @jobs = Job.published.order("created_at DESC")
    @jobs = case params[:order]
            when 'by_lower_bound'
                Job.published.where(:category => "cars_auto_parts").order('wage_lower_bound DESC')
            when 'by_upper_bound'
                Job.published.where(:category => "cars_auto_parts").order('wage_upper_bound DESC')
            else
                Job.published.where(:category => "cars_auto_parts").recent
            end
  end

  def estate
    # @jobs = Job.all
    # @jobs = Job.published.order("created_at DESC")
    @jobs = case params[:order]
            when 'by_lower_bound'
                Job.published.where(:category => "estate").order('wage_lower_bound DESC')
            when 'by_upper_bound'
                Job.published.where(:category => "estate").order('wage_upper_bound DESC')
            else
                Job.published.where(:category => "estate").recent
            end
  end

  def new
    @job = Job.new
  end
  def create
     @job = Job.new(job_params)
     if @job.save
       redirect_to jobs_path
     else
       render :new
     end
  end
  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to jobs_path
  end
  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      redirect_to jobs_path
    else
      render :edit
    end
  end
  private
  def job_params
    params.require(:job).permit(:title, :description, :category, :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden)
  end
end
