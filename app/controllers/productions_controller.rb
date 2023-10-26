class ProductionsController < ApplicationController
  before_action :set_production, only: %i[ show edit update destroy ]

  def index
    @productions = Production.joins(:product).where(product: {user: current_user}).all.order(date_time: :desc)
    prepare_form
  end

  def show
  end

  def new
    @production = Production.new
    prepare_form
  end

  def edit
    prepare_form
  end

  def create
    @production = Production.new(production_params)

    if @production.save
      redirect_to root_path, notice: "Produção adicionada com sucesso."
    else
      prepare_form
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @production.update(production_params)
      redirect_to production_url(@production), notice: "Produção atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @production.destroy

    respond_to do |format|
      format.html { redirect_to productions_url, notice: "Produção deletada" }
      format.json { head :no_content }
    end
  end

  private
    def set_production
      @production = Production.find(params[:id])
    end

    def production_params
      params.require(:production).permit(:quantity, :date_time, :product_id)
    end

    def prepare_form
      @products = current_user.products.all.map { |product| [product.name, product.id] }
    end
end
