class Devise::ConfirmPhoneNumberController < DeviseController
  prepend_before_filter :fetch_resource
  before_filter :check_max_attempts, :handle_sms_confirmation

  def show
  end

  def create
    render :show and return if params[:code].nil?
    if resource.attempt_confirmation! params[:code]
      warden.session(resource_name)[:need_sms_confirmation] = false 
      redirect_to :root
      flash[:notice] = "Your phone number was confirmed successfully"
    else
      if resource.exceeded_max_confirmation_attempts?
        flash[:notice] = "Exceeded max confirmation attempts. Account locked"
        sign_out_and_redirect resource
      else
        flash[:notice] = "That code was incorrect, try again"
        render :show
      end
    end
  end

  def new
    flash[:notice] = "New code sent to #{resource.phone_number}"
    resource.send_confirmation_instructions!
    redirect_to sms_confirmation_path_for resource
  end

  private

  def fetch_resource
    self.resource = send "current_#{resource_name}"
  end

  def check_max_attempts
    redirect to :root and return if resource.nil?
    if resource.exceeded_max_confirmation_attempts?
      flash[:notice] = "You have exceeded the maximum number of confirmation attempts, and your account is locked."
      sign_out_and_redirect resource
    end
  end
end
