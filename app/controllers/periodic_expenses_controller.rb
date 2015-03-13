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
    @expense = PeriodicExpense.find(params[:id])
  end

  def update
    @expense = PeriodicExpense.find(params[:id])
    if @expense.update(expense_params)
      redirect_to @expense
    else
      render 'edit'
    end
  end

  def destroy
    @expense = PeriodicExpense.find(params[:id])
    @expense.destroy

    redirect_to periodic_expenses_path
  end

  private
  def expense_params
    params.require(:expense).permit(:description, :value, :start_date, :end_date)
  end
end
