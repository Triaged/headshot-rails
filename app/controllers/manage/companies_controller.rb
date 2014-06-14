class Manage::CompaniesController < ApplicationController

	def show
    @company = current_company
  end

end
