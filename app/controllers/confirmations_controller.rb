# app/controllers/confirmations_controller.rb
class ConfirmationsController < Devise::ConfirmationsController
  # Remove the first skip_before_filter (:require_no_authentication) if you
  # don't want to enable logged users to access the confirmation page.
  layout "home"
  skip_before_filter :require_no_authentication
  skip_before_filter :authenticate_user!

  # PUT /resource/confirmation
  def update
    with_unconfirmed_confirmable do
      if @confirmable.has_no_password?
        @confirmable.attempt_set_password(params[:user])
        if @confirmable.valid? and @confirmable.password_match?
          do_confirm
        else
          do_show
          @confirmable.errors.clear #so that we wont render :new
        end
      else
        @confirmable.errors.add(:email, 'password_already_set')
      end
    end

    if !@confirmable.errors.empty?
      self.resource = @confirmable
      render 'devise/confirmations/new' #Change this if you don't have the views on default path
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    with_unconfirmed_confirmable do
      if @confirmable.has_no_password?
        do_show
      else
        do_confirm
      end
    end
    if !@confirmable.errors.empty?
      self.resource = @confirmable
      render 'devise/confirmations/new' #Change this if you don't have the views on default path 
    end
  end

  protected

  def with_unconfirmed_confirmable
    original_token = params[:confirmation_token]
    confirmation_token = Devise.token_generator.digest(User, :confirmation_token, original_token)
    @confirmable = User.find_or_initialize_with_error_by(:confirmation_token, confirmation_token)
    if !@confirmable.new_record?
      @confirmable.only_if_unconfirmed {yield}
    end
  end

  def do_show
    @confirmation_token = params[:confirmation_token]
    @requires_password = true
    self.resource = @confirmable
    render 'devise/confirmations/show' #Change this if you don't have the views on default path
  end

  def do_confirm
    @confirmable.confirm!
    set_flash_message :notice, :confirmed
    sign_in_and_redirect(resource_name, @confirmable)
    track_confirm
  end

  def track_confirm
    Analytics.track(
      user_id: current_user.id,
      event: 'confirmed_account',
      properties: {
        "company.id" => current_user.company.id,
        "company.name" => current_user.company.name
      },
      context: {
        traits: { company_id: current_user.company.id, company_name: current_user.company.name }
      }
    )
  end
end