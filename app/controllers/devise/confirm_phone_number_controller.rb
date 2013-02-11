class Devise::ConfirmPhoneNumberController < DeviseController

  prepend_before_filter :fetch_resource

  def show
  end

  def create
    render :show and return if params[:code].nil?
    if resource.attempt_confirmation! params[:code]
      redirect_to :root
      flash[:notice] = "Your phone number was confirmed successfully."
    else
      if resource.exceeded_max_confirmation_attempts?
        sign_out_and_redirect_with_opts(resource, alert: "You have exceeded the maximum number of confirmation attempts, and your account has been locked. Contact an administrator to unlock.")
      else
        flash[:error] = "That code was incorrect, please try again"
        render :show
      end
    end
  end

  def new
    flash[:notice] = "A new code was sent to #{resource.phone_number}."
    resource.send_confirmation_instructions!
    redirect_to sms_confirmation_path_for resource
  end

  private

  def fetch_resource
    self.resource = send "current_#{resource_name}"
  end

#  def check_max_attempts
#    redirect to :root and return if resource.nil?
#    if resource.exceeded_max_confirmation_attempts?
#      flash[:notice] = "You have exceeded the maximum number of confirmation attempts, and your account is locked."
#      sign_out_and_redirect resource
#    end
#  end
end
