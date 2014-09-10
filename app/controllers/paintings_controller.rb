class PaintingsController < ApplicationController
  before_action :find_painting, except: [:index, :batch_destroy, :fader]

  before_action :setup_sorting_variables, only: [:index]

  def fader
    @p = Painting.where{ ordinal != nil }.
      ordered_by(:ordinal, :asc)
    @links = []
    @p.each do |p|
      @links << p.image.to_s
    end
  end
  
  def index
    sort_key = [:image, :title, :caption, :ordinal, :created, :updated][@sort]
    direction = (@asc == 1) ? :asc : :desc
    @paintings = Painting.ordered_by(sort_key, direction).page(@page).per_page(10)
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
    if @painting.nil?
      flash[:error] = "Can't find painting" 
    elsif @painting.new_record?
      flash[:error] = "Can't destroy new painting" 
    else
      flash[:notice] = "You destroyed #{@painting.image}"
      @painting.destroy
    end

    respond_to do |format|
      format.html { redirect_to paintings_url }
      format.json { head :no_content }
    end
  end

  def batch_destroy
    ids = params[:painting_ids] || []
    if ids.length > 0
      paintings = Painting.where{ id >> ids }
      images = paintings.map(&:image).join(", ")
      paintings.destroy_all
      flash[:notice] = "Successfully destroyed the images: " + images
    else
      flash[:error] = "Select some images to destroy first"
    end

    respond_to do |format|
      format.html { render nothing: true }
      format.json { head :no_content }
    end
  end

  private
    def find_painting
      @painting = if params[:id].blank?
        Painting.new
      else
        Painting.where(id: params[:id]).first
      end
    end

    def setup_form
      render :form
    end

    def save_form
      @painting.attributes = painting_params
      if @painting.save
        flash[:notice] = "Successfully saved #{@painting.title}"
        redirect_to paintings_url
      else
        setup_form
      end
    end

    def painting_params
      params.require(:painting).permit(:image, :title, :caption, :ordinal, :remote_image_url)
    end

    def setup_sorting_variables
      @sort = params[:sort].blank? ? 0 : params[:sort].to_i
      @asc = params[:asc].blank? ? 0 : params[:asc].to_i
      @page = params[:page].blank? ? 1 : params[:page].to_i
    end
end
