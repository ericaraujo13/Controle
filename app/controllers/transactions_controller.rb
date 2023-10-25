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
    if @transaction.save
      redirect_to root_path, notice: "Venda cadastrada com sucesso."
    else
      prepare_form
      render :new, status: :unprocessable_entity
    end
  end

  def update
      if @transaction.update(transaction_params)
        redirect_to transaction_url(@transaction), notice: "Venda atualizada com sucesso."
      else
        render :edit, status: :unprocessable_entity
      end
  end

  def destroy
    @transaction.destroy
    redirect_to transactions_url, notice: "Venda excluida."
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
