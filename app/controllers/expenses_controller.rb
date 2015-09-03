class ExpensesController < ApplicationController
  def budget
    @budget_date = DateTime.parse(params[:budget_date] || DateTime.now.utc.to_s)
    @expenses = Expense.get_expenses_same_month_of(@budget_date)
    @periodic_expenses = PeriodicExpense.get_expenses_for_month(@budget_date)
    @expected_expenses = ExpectedExpense.not_realized_on(@budget_date)
    render 'all'
  end

  def index
    @expenses = Expense.all.order(:budget_date).reverse_order
  end

  def new
    if ExpectedExpense.exists? params[:expected_expense_id]
      @expected_expense = ExpectedExpense.find params[:expected_expense_id]
    end
    @expense = Expense.new() unless @expense
    @contributors = Contributor.all.order(:firstName)
    @categories = Category.all.order(:created_at)
  end

  def create
    @expense = Expense.new expense_params
    if @expense.save
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
      params.require(:expense).permit(:description, :value, :budget_date, :category_id, :contributor_id, :expected_expense_id)
    end
end
