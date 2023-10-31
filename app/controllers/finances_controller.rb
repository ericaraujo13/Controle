class FinancesController < ApplicationController
  before_action :set_finance, only: %i[ show edit update destroy ]

  def index
    @finances = current_user.finances.all
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

    respond_to do |format|
      if @finance.save
        format.html { redirect_to finance_url(@finance), notice: "Finance was successfully created." }
        format.json { render :show, status: :created, location: @finance }
      else  
        prepare_form
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @finance.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @finance.update(finance_params)
        format.html { redirect_to finance_url(@finance), notice: "Finance was successfully updated." }
        format.json { render :show, status: :ok, location: @finance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @finance.errors, status: :unprocessable_entity }
      end
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
