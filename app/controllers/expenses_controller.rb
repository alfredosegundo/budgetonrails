class ExpensesController < ApplicationController
  def index
    @expenses = Expense.all.order(:created_at)
  end

  def new
    if ExpectedExpense.exists? params[:id]
      @expected_expense = ExpectedExpense.find params[:id]
      @expense = Expense.new() unless @expense
    else
      @expense = Expense.new() unless @expense
    end
    @contributors = Contributor.all.order(:firstName)
    @categories = Category.all.order(:created_at)
  end

  def create
    @expense = Expense.new expense_params
    if @expense.save
      if params[:id] and ExpectedExpense.exists? expected_expense_params[:id]
        ee = ExpectedExpense.find expected_expense_params[:id]
        ee.expenses << @expense
      end
      redirect_to expense_path(@expense)
    else
      render 'new'
    end
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def edit
    @expense = Expense.find(params[:id])
    @contributors = Contributor.all.order(:firstName)
    @categories = Category.all.order(:created_at)
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update(expense_params)
      redirect_to @expense
    else
      render 'edit'
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    redirect_to expenses_path
  end

  private
    def expense_params
      params.require(:expense).permit(:description, :value, :budget_date, :category_id, :contributor_id)
    end

    def expected_expense_params
      params.require(:expected_expense).permit(:id)
    end

end
