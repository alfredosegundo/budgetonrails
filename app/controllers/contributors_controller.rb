class ContributorsController < ApplicationController

	def index
		@contributors = Contributor.all
	end

	def new
		@contributor = Contributor.new() unless @contributor
	end

	def create
		@contributor = Contributor.new(contributor_create_params)
		if @contributor.save
			redirect_to @contributor
		else
			render 'new'
		end
	end

	def show
		@contributor = Contributor.find(params[:id])
	end

	def edit
		@contributor = Contributor.find(params[:id])
	end

	def update
		@contributor = Contributor.find(params[:id])
		if @contributor.update(contributor_update_params)
			redirect_to @contributor
		else
			render 'edit'
		end
	end

	def destroy
		@contributor = Contributor.find(params[:id])
		@contributor.destroy
		
		redirect_to contributors_path
	end
	private
		def contributor_create_params
			params.require(:contributor).permit(:firstName, :lastName, :email, :email_confirmation)
		end

		def contributor_update_params
			params.require(:contributor).permit(:firstName, :lastName)
		end
end
