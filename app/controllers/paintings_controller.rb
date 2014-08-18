class PaintingsController < ApplicationController
  before_action :set_painting, only: [:show, :edit, :update, :destroy]

  before_action :setup_sorting_variables, only: [:index]

  def fader
    @p = Painting.ordered_by(:created, :asc).where(id: [358, 359, 360])
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
    @painting = Painting.new
  end

  def edit
  end

  def create
    @painting = Painting.new(painting_params)

    respond_to do |format|
      if @painting.save
        format.html { redirect_to @painting, notice: 'Painting was successfully created.' }
        format.json { render action: 'show', status: :created, location: @painting }
      else
        format.html { render action: 'new' }
        format.json { render json: @painting.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @painting.update(painting_params)
        format.html { redirect_to @painting, notice: 'Painting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @painting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @painting.destroy
    respond_to do |format|
      format.html { redirect_to paintings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_painting
      @painting = Painting.where(id: params[:id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def painting_params
      params.require(:painting).permit(:image, :title, :caption, :ordinal, :remote_image_url)
    end

    def setup_sorting_variables
      @sort = params[:sort].blank? ? 0 : params[:sort].to_i
      @asc = params[:asc].blank? ? 0 : params[:asc].to_i
      @page = params[:page].blank? ? 1 : params[:page].to_i
    end
end
