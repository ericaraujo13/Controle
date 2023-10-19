class ProductionsController < ApplicationController
  before_action :set_production, only: %i[ show edit update destroy ]

  def index
    @productions = Production.all
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

    respond_to do |format|
      if @production.save
        format.turbo_stream { redirect_to root_path, notice: "Produção adicionada com sucesso." }
        format.json { render :show, status: :created, location: @production }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @production.errors, status: :unprocessable_entity }
        prepare_form
      end
    end
  end

  def update
    respond_to do |format|
      if @production.update(production_params)
        format.html { redirect_to production_url(@production), notice: "Produção atualizada com sucesso." }
        format.json { render :show, status: :ok, location: @production }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @production.errors, status: :unprocessable_entity }
      end
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
      @products = Product.all.map { |product| [product.name, product.id] }
    end
end
