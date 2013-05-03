class EntriesController < ApplicationController
	after_filter :word_count, :only => [:create, :update]

	def create
		@entry = Entry.new(params[:entry])

		if @entry.save
			@entry.words = @entry.content.split.size
			redirect_to entries_path, notice: "successfully created entry"
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
		@word_count = Entry.sum('words')
		@entry_count = Entry.count
		@avg_words = @word_count/@entry_count
	end

	def new
		@entry = Entry.new
	end

	def show
		@entry = Entry.find(params[:id])
		@numbers = occurances 
	end

	def stats
		@word_count = Entry.sum('words')
		@entry_count = Entry.count
		@avg_words = @word_count/@entry_count
		@capsule_count = Entry.where('time_capsule > ?', Time.now).count
	end

	def update
		@entry = Entry.find(params[:id])

    	if @entry.update_attributes(params[:entry])
    		@entry.words = @entry.content.split.size
      		redirect_to entries_path, notice: 'Entry was successfully updated.'
    	else
      		render action: "edit"
    	end
	end

	private

	def word_count
		@entry.words = @entry.content.split.size
		@entry.save
	end

	def occurances
		data = []
		exclude = ["a", "an", "the", "of", "to", "do", "is", "and", "which", "who", "where", "when", "what", "with", "for", "from", "at", "this", "that", "these", "with"]
		frequency = Hash.new(0)
		@list = @entry.content.scan(/[^\W\d][\w'-]*(?<=\w)/) do |w|  
			unless exclude.include?(w.downcase) 
				frequency[w] += 1 
			end
		end
		frequency.each {|key,value| data.push({text: key, weight: value})}
		return data.to_json
	end
end
