class VisitorsController < ApplicationController
	def index
		@home = Home.first
	end
end
