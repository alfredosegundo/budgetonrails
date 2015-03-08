class ContributionsController < ApplicationController

	def create
		@contributor = Contributor.find(params[:contributor_id])
		puts strong_params
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
	      redirect_to contributor_path
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
