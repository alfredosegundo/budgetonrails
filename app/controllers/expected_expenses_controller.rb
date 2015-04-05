class ExpectedExpensesController < ApplicationController

  def index
    @expenses = ExpectedExpense.all
  end

  def new
    @expense = ExpectedExpense.new() unless @expense
  end

  def create
    @expense = ExpectedExpense.new(expense_params)
    if @expense.save
      redirect_to expected_expense_path(@expense)
    else
      render 'new'
    end
  end

  def show
    @expense = ExpectedExpense.find params[:id]
  end

  def edit
    @expense = ExpectedExpense.find params[:id]
  end

  def update
    @expense = ExpectedExpense.find params[:id]
    if @expense.update(expense_params)
      redirect_to @expense
    else
      render 'edit'
    end
  end

  def destroy
    @expense = ExpectedExpense.find params[:id]
    @expense.destroy

    redirect_to expected_expenses_path
  end

  private
    def expense_params
      params.require(:expense).permit(:description, :value)
    end
end
