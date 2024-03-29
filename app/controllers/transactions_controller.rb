class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]

  def index
    params[:q] ||= {}
    if params[:q][:date_time_lteq].present?
      params[:q][:date_time_lteq] = params[:q][:date_time_lteq].to_date.end_of_day
    end
  
    @q = Transaction.joins(:product).where(product: {user: current_user}).ransack(params[:q])
    @transactions = @q.result.page(params[:page]).order(date_time: :desc)
    @total_amount = balance
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
      register_sell
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

    def register_sell
      current_user.finances.create(transaction_type: "entrada", description: "Venda", amount: @transaction.amount)
    end

    def balance
      Transaction.joins(:product).where(product: {user: current_user}).all.sum(:amount)
    end
end
