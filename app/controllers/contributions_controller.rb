class ContributionsController < ApplicationController

	def index
		budget_date = DateTime.parse(params[:budget_date] || DateTime.now.utc.to_s)
		@contributions = Contribution.get_contributions_for_month(budget_date)
	end
	
	def create
		@contributor = Contributor.find(params[:contributor_id])
    @contribution = @contributor.contributions.create(strong_params)
    redirect_to contributor_path(@contributor)
	end

	def edit
		@contribution = Contribution.find(params[:id])
		@contributor = Contributor.find(@contribution.contributor_id)
	end

	def update
	    @contribution = Contribution.find(params[:id])
	    @contributor = Contributor.find(@contribution.contributor_id)
	    if @contribution.update(strong_params)
	      redirect_to @contributor
	    else
	      render 'edit'
	    end
	end	

	def destroy
		@contribution = Contribution.find(params[:id])
		@contribution.destroy

		redirect_to contributors_path
	end

	private
    def strong_params
			params.require(:contribution).permit(:amount, :budget_date)
    end
end
