class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]

  def index
    @transactions = Transaction.joins(:product).where(product: {user: current_user}).all
    @total_amount = @transactions.sum(:amount)
  end

  def show
  end

  def new
    @transaction = Transaction.new
    prepare_form
  end

  def edit
    prepare_form
  end

  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to root_path, notice: "Venda cadastrada com sucesso." }
        format.json { render :show, status: :created, location: @transaction }
      else
        prepare_form
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.turbo_stream
        format.html { redirect_to transaction_url(@transaction), notice: "Venda atualizada com sucesso." }
      else
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Venda excluida." }
      format.json { head :no_content }
    end
  end

  private
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.require(:transaction).permit(:product_id, :quantity, :date_time, :amount)
    end

    def prepare_form
      @products = current_user.products.all.map { |product| [product.name, product.id] }
    end
end
