class RevenuesController < ApplicationController
  def budget
    budget_date = DateTime.parse(params[:budget_date] || DateTime.now.utc.to_s)
  	@revenues = Revenue.get_for_month(budget_date).order(:created_at)
    render 'index'
  end

  def index
    @revenues = Revenue.limit(100).order(:budget_date).reverse_order
  end

  def new
  	@revenue = Revenue.new
    @categories = Category.all.order(:created_at)
  end

  def create
  	@revenue = Revenue.new revenue_params
    if @revenue.save
      redirect_to revenue_path(@revenue)
    else
      @categories = Category.all.order(:created_at)
      render 'new'
    end
  end

  def edit
    @revenue = Revenue.find(params[:id])
    @categories = Category.all.order(:created_at)
  end

  def update
    @revenue = Revenue.find(params[:id])
    if @revenue.update(revenue_params)
      redirect_to @revenue
    else
      @categories = Category.all.order(:created_at)
      render 'edit'
    end
  end

  def destroy
    @revenue = Revenue.find(params[:id])
    @revenue.destroy

    redirect_to revenues_path
  end

  def show
    @revenue = Revenue.find(params[:id])
  end

  private
    def revenue_params
      params.require(:revenue).permit(:description, :amount, :budget_date, :category_id)
    end
end
