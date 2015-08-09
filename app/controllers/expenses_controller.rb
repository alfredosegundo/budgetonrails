class ExpensesController < ApplicationController
  def index
    @expenses = Expense.all
  end

  def new
    if ExpectedExpense.exists? params[:id]
      @expected_expense = ExpectedExpense.find params[:id]
      @expense = Expense.new() unless @expense
    else
      @expense = Expense.new() unless @expense
    end
    @contributors = [["empty", 0]]
    Contributor.all.each do |c|
      @contributors.push([c.firstName, c.id])
    end
  end

  def create
    @expense = Expense.new expense_params
    if @expense.save
      if params[:id] and ExpectedExpense.exists? expected_expense_params[:id]
        ee = ExpectedExpense.find expected_expense_params[:id]
        ee.expenses << @expense
      end
      if params[:contributor_id] != 0 and Contributor.exists?(params[:contributor_id])
        @contributor = Contributor.find(params[:contributor_id])
        @contributor.expenses << @expense
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
    @contributors = [["-- choose a contributor --",0]]
    Contributor.all.map do |c|
      @contributors.push([c.firstName, c.id])
    end
    @selected_contributor = if @expense.contributor then @expense.contributor.id else 0 end
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
      params.require(:expense).permit(:description, :value, :budget_date)
    end

    def expected_expense_params
      params.require(:expected_expense).permit(:id)
    end

end
