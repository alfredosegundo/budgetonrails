class RevenuesController < ApplicationController
  def index
  	@revenues = Revenue.all
  end

  def new
  	@revenue = Revenue.new
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
      params.require(:revenue).permit(:description, :amount, :budget_date)
    end
end
