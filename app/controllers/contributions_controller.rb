class ContributionsController < ApplicationController

	def create
		@contributor = Contributor.find(params[:contributor_id])
	    @contribution = @contributor.contributions.create(strong_params)
	    redirect_to contributor_path(@contributor)
	end

	def destroy
		@contribution = Contribution.find(params[:id])
		@contribution.destroy

		redirect_to contributors_path
	end

private
    def strong_params
    	params[:contribution][:created_at] = DateTime.now
		params.require(:contribution).permit(:amount, :created_at)
    end
end
