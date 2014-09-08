class Administration::ManageUsersController < ApplicationController
  respond_to :html, :js, :json

  before_action :authenticate_user!
  before_action :setup_sorting_variables, only: [:index]
  before_action :find_user, except: [:index]

  def index
    sort_key = [:email, :created, :updated][@sort]
    direction = (@asc == 1) ? :asc : :desc
    
    @users = User.similar_emails(params[:search]).
      ordered_by(sort_key, direction).page(@page).per_page(10)
  end

  def show
    present(@user).to_json
  end

  def new
    setup_form
  end

  def edit
    setup_form
  end

  def update
    save_form
  end

  def create
    save_form
  end

  def destroy
    if @user.nil?
      flash[:error] = "Can't find user" 
    elsif @user.new_record?
      flash[:error] = "Can't destroy new user" 
    else
      flash[:notice] = "You destroyed #{@user.email}"
      @user.destroy
    end

    redirect_to administration_users_path
  end

private
  def find_user
    @user = if params[:id].blank?
      User.new
    else
      User.where(id: params[:id]).first
    end
  end

  def setup_form
    render :form
  end

  def save_form
    @user.attributes = user_params
    if @user.save
      flash[:notice] = "Successfully saved #{@user.email}"
      redirect_to administration_users_url
    else
      setup_form
    end
  end
  
  def user_params
    params[:user].permit(:email, :password, :password_confirmation)
  end

  def view_content
    render params[:action]
  end

  def setup_sorting_variables
    @sort = params[:sort].blank? ? 0 : params[:sort].to_i
    @asc = params[:asc].blank? ? 0 : params[:asc].to_i
    @page = params[:page].blank? ? 1 : params[:page].to_i
  end
end
