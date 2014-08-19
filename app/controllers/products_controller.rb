class ProductsController < ApplicationController
  before_action :setup_sorting_variables, only: [:index]
  before_action :find_product, except: [:index]
  
  def index
    sort_key = [:name, :descritpion, :cost, :created, :updated][@sort]
    direction = (@asc == 1) ? :asc : :desc
    
    @products = Product.similar_names(params[:search]).
      similar_descriptions(params[:search]).
      ordered_by(sort_key, direction).page(@page).per_page(10)
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
    if @product.nil?
      flash[:error] = "Can't find product" 
    elsif @product.new_record?
      flash[:error] = "Can't destroy new product" 
    else
      flash[:notice] = "You destroyed #{@product.name}"
      @product.destroy
    end

    redirect_to products_path
  end

  private
    def find_product
      @product = if params[:id].blank?
        Product.new
      else
        Product.where(id: params[:id]).first
      end
    end

    def setup_form
      render :form
    end

    def save_form
      @product.attributes = product_params
      if @product.save
        flash[:notice] = "Successfully saved #{@product.name}"
        redirect_to products_url
      else
        setup_form
      end
    end

    def product_params
      params.require(:product).permit(:name, :description, :cost)
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
