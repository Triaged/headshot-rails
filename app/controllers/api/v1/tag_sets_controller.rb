class API::V1::TagSetsController < APIController

	def index
		@tag_sets = TagSet.all
		respond_with @tag_sets
	end
	
end
