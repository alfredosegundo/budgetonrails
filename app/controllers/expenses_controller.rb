class ExpensesController < ApplicationController
  def index
    @expenses = Expense.all
  end

  def new
    @expense = Expense.new() unless @expense
    @contributors = [["empty", 0]]
    Contributor.all.each do |c|
      @contributors.push([c.firstName, c.id])
    end
  end

  def create
    if Contributor.exists?(params[:contributor_id])
      @contributor = Contributor.find(params[:contributor_id])
      @contributor.expenses.create(expense_params)
      if @contributor.save
        redirect_to contributor_path(@contributor)
      else
        render 'new'
      end
    else
      @expense = Expense.new(expense_params)
      if @expense.save
        redirect_to expense_path(@expense)
      else
        render 'new'
      end
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

end
