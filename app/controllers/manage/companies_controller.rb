class Manage::CompaniesController < ApplicationController
	before_action :set_company

	def show
  end

  def update
  	if @company.update(company_params)
      redirect_to manage_company_path(), notice: 'Company was successfully updated.'
    else
      render :show
    end
  end

private
	
	def set_company
		@company = current_company
	end

	def company_params
		params[:company].permit(:name, :uses_departments)
	end

end
