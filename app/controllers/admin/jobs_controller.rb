class Admin::JobsController < ApplicationController
  before_action :authenticate_user!, only:[:new, :create, :update, :edit, :destroy]
  before_action :require_is_admin
  layout "admin"
  def show
    @job = Job.find(params[:id])
  end
  def index
    @jobs = Job.all
  end
  def new
    @job = Job.new
  end
  def create
     @job = Job.new(job_params)
     if @job.save
       redirect_to admin_jobs_path
     else
       render :new
     end
  end
  def publish
    @job = Job.find(params[:id])
    @job.publish!
    redirect_to :back
  end
  def hide
    @job = Job.find(params[:id])
    @job.hide!
    redirect_to :back
  end
  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to admin_jobs_path
  end
  def edit
    @job = Job.find(params[:id])
  end

  def internet_electronic_commerce
    # @jobs = Job.all
    # @jobs = Job.order("created_at DESC")
    @jobs = case params[:order]
            when 'by_lower_bound'
                Job.where(:category => "internet_electronic_commerce").order('wage_lower_bound DESC')
            when 'by_upper_bound'
                Job.where(:category => "internet_electronic_commerce").order('wage_upper_bound DESC')
            else
                Job.where(:category => "internet_electronic_commerce").recent
            end
  end

  def finace_investment_security
    # @jobs = Job.all
    # @jobs = Job.order("created_at DESC")
    @jobs = case params[:order]
            when 'by_lower_bound'
                Job.where(:category => "finace_investment_security").order('wage_lower_bound DESC')
            when 'by_upper_bound'
                Job.where(:category => "finace_investment_security").order('wage_upper_bound DESC')
            else
                Job.where(:category => "finace_investment_security").recent
            end
  end

  def cars_auto_parts
    # @jobs = Job.all
    # @jobs = Job.order("created_at DESC")
    @jobs = case params[:order]
            when 'by_lower_bound'
                Job.where(:category => "cars_auto_parts").order('wage_lower_bound DESC')
            when 'by_upper_bound'
                Job.where(:category => "cars_auto_parts").order('wage_upper_bound DESC')
            else
                Job.where(:category => "cars_auto_parts").recent
            end
  end

  def estate
    # @jobs = Job.all
    # @jobs = Job.order("created_at DESC")
    @jobs = case params[:order]
            when 'by_lower_bound'
                Job.where(:category => "estate").order('wage_lower_bound DESC')
            when 'by_upper_bound'
                Job.where(:category => "estate").order('wage_upper_bound DESC')
            else
                Job.where(:category => "estate").recent
            end
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      redirect_to admin_jobs_path
    else
      render :edit
    end
  end
  private
  def job_params
    params.require(:job).permit(:title, :description,:category,  :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden)
  end
end
