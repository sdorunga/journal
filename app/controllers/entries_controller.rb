class EntriesController < ApplicationController
	def create
		@entry = Entry.new(params[:entry])

		if @entry.save
			redirect_to @entry, notice: "successfully created entry"
		else
			render action: "new"
		end
	end

	def destroy
		@entry = Entry.find(parans[:id])
		@entry.destroy

		redirect_to entries_path
	end

	def edit
		@entry = Entry.find(params[:id])
	end

	def index
		@entries = Entry.all
	end

	def new
		@entry = Entry.new
	end

	def show
		@entry = Entry.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        redirect_to @entry, notice: 'Entry was successfully updated.'
      else
        render action: "edit"
      end
    end
end
