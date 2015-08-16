class RevenuesController < ApplicationController
  def index
  	@revenues = Revenue.all.order(:created_at)
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
