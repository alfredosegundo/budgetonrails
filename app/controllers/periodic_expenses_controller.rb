class PeriodicExpensesController < ApplicationController
  def index
  	@expenses = PeriodicExpense.all
  end

  def new
    @expense = PeriodicExpense.new() unless @expense
  end

  def create
  	@expense = PeriodicExpense.new(expense_params)
	if @expense.save
    	redirect_to periodic_expense_path(@expense)
  	else
    	render 'new'
  	end
  end

  def show
    @expense = PeriodicExpense.find(params[:id])
  end

  def edit
  end

  def destroy
  end

  private
  def expense_params
    params.require(:periodic_expense).permit(:description, :value, :start_date, :end_date)
  end
end
