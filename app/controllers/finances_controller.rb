class FinancesController < ApplicationController
  before_action :set_finance, only: %i[ show edit update destroy ]
  include Exportable

  def index
    params[:q] ||= {}
    if params[:q][:created_at_lteq].present?
      params[:q][:created_at_lteq] = params[:q][:created_at_lteq].to_date.end_of_day
    end

    @q = current_user.finances.ransack(params[:q])
    @finances = @q.result.page(params[:page]).order(created_at: :desc)
    @total_amount = total_balance
  end

  def show
  end

  def new
    @finance = current_user.finances.new
    prepare_form
  end

  def edit
    prepare_form
  end

  def create
    @finance = current_user.finances.new(finance_params)
    if @finance.save
      redirect_to finances_path, notice: "Finance was successfully created."
    else  
      prepare_form
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @finance.update(finance_params)
      redirect_to finance_url(@finance), notice: "Finance was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @finance.destroy

    respond_to do |format|
      format.html { redirect_to finances_url, notice: "Finance was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_finance
      @finance = current_user.finances.find(params[:id])
    end

    def finance_params
      params.require(:finance).permit(:transaction_type, :description, :amount)
    end

    def prepare_form
      @finances = current_user.finances.transaction_types.keys.map{ |key| [key.humanize, key] }
    end

    def total_balance
      total_money = current_user.finances.entrada.sum(:amount)
      waste = current_user.finances.saida.sum(:amount)
      balance = total_money - waste
    end
end
