class ContributionFactorsController < ApplicationController

  def index
    @factors = ContributionFactor.all
  end
  
  def new
    @contribution_factor = ContributionFactor.new() unless @contribution_factor
  end

  def create
      @contribution_factor = ContributionFactor.new(contribution_factor_params)
      if @contribution_factor.save
        redirect_to contribution_factor_path(@contribution_factor)
      else
        render 'new'
      end
  end

  def show
    @factor = ContributionFactor.find(params[:id])
  end

  def update
  end

  def destroy
    factor = ContributionFactor.find(params[:id])
    factor.destroy

    redirect_to contribution_factors_path
  end

  private
  def contribution_factor_params
    params.require(:contribution_factor).permit(:factor, :initial_date)
  end
end
