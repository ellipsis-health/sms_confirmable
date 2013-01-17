module SmsConfirmable
  module Controllers
    module Helpers
      extend ActiveSupport::Concern

      included do
        before_filter :handle_sms_confirmation
      end

      private

      def handle_sms_confirmation
        unless devise_controller?
          Devise.mappings.keys.flatten.any? do |scope|
            if signed_in? scope and not current_user.confirmed?
              handle_failed_sms_confirmation scope
            end
          end
        end
      end

      def handle_failed_sms_confirmation scope
        if request.format.present? and request.format.html?
          session["#{scope}_return_to"] = request.path if request.get?
          redirect_to sms_confirmation_path_for scope
        else
          render nothing: true, status: :unauthorized
        end
      end
     
      def sms_confirmation_path_for(resource_or_scope=nil)
        scope = Devise::Mapping.find_scope! resource_or_scope
        send "#{scope}_confirm_phone_number_path"
      end

    end
  end
end
