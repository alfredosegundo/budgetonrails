class ContributorsController < ApplicationController

	def index
		@contributors = Contributor.all
	end

	def new
	end

	def create
		@contributor = Contributor.new(article_params)
		@contributor.save
		redirect_to @contributor
	end

	def show
		@contributor = Contributor.find(params[:id])
	end

	private
		def article_params
			params.require(:contributor).permit(:firstName, :lastName)
		end
end
