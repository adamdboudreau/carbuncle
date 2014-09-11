class NotesController < ApplicationController
  before_action :setup_sorting_variables, only: [:index]
  before_action :find_note, except: [:index]
  
  def index
    sort_key = [:value, :email, :created, :updated][@sort]
    direction = (@asc == 1) ? :asc : :desc
    
    @notes = Note.similar_notes(params[:search]).
      ordered_by(sort_key, direction).page(@page).per_page(10)
  end

  def search_users
    @users = User.similar_emails(params[:partial_email]).
      ordered_by(:email, :asc).limit(10)

    render partial: "/layouts/user_list"
  end

  def show
  end

  def new
    setup_form
  end

  def edit
    setup_form
  end

  def create
    save_form
  end

  def update
    save_form
  end

  def destroy
    if @note.nil?
      flash[:error] = "Can't find note" 
    elsif @note.new_record?
      flash[:error] = "Can't destroy new note" 
    else
      flash[:notice] = "You destroyed #{@note.value}"
      @note.destroy
    end

    redirect_to notes_path
  end

  private
    def find_note
      @note = if params[:id].blank?
        Note.new
      else
        Note.where(id: params[:id]).first
      end
    end

    def setup_form
      render :form
    end

    def save_form
      @note.attributes = note_params
      if @note.save
        flash[:notice] = "Successfully saved #{@note.value}"
        redirect_to notes_url
      else
        setup_form
      end
    end

    def note_params
      params.require(:note).permit(:value, :user_id)
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
