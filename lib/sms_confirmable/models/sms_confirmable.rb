module Devise
  module Models
    module SmsConfirmable
      extend ActiveSupport::Concern

      module ClassMethods
        ::Devise::Models.config(self,:confirmation_code_length,:max_confirmation_attempts)
      end

      included do
        after_create :send_confirmation_instructions!, :if => :confirmation_required?
      end

      def self.required_fields klass
        required_methods = [:sms_confirmation_code, :sms_confirmation_salt, :confirmed_at, 
                            :confirmation_sent_at, :sms_confirmation_attempts]
      end

      def attempt_confirmation! code
        self.sms_confirmation_attempts += 1
        if code_is_correct? code
          confirm!
          true
        else
          save(validate: false)
          false 
        end
      end
      
      def confirm!
        self.sms_confirmation_code = nil
        self.sms_confirmation_salt = nil
        self.confirmed_at = DateTime.now.utc
        save(validate: false)
      end

      def confirmed?
        !!self.confirmed_at
      end

      def exceeded_max_confirmation_attempts?
        self.sms_confirmation_attempts >= self.class.max_confirmation_attempts
      end

      # Generates a confirmation code and sends it
      # to the user's phone number. The code must be regenerated
      # every time this is called because only a digest of the code is
      # stored in the database.
      def send_confirmation_instructions!
        code = generate_sms_confirmation_code
        send_message "Your confirmation code is #{code}."
        self.confirmation_sent_at = DateTime.now.utc
        save(validate: false)
      end

      # Should override this to send the SMS
      def send_message message
        Rails.logger.info "Sending SMS to #{phone_number}: #{message}"
      end

      # Returns true if the user can be allowed to log in (i.e. is confirmed or is not required to confirm)
      def active_for_authentication?
        super && !exceeded_max_confirmation_attempts?
      end

      # Supplies the messages if the user has not been confirmed
      def inactive_message
        !confirmed? ? :unconfirmed : super
      end

      # Override to establish rules regarding when confirmation
      # is required
      def confirmation_required?
        !confirmed?
      end

      protected

      def generate_sms_confirmation_code
        chars = ('0'..'9').to_a + ('A'..'Z').to_a
        code = (0..self.class.confirmation_code_length).map { 
          chars[SecureRandom.random_number(chars.length)] 
        }.join
        salt = SCrypt::Engine.generate_salt(salt_size: 32)
        self.sms_confirmation_code = SCrypt::Engine.hash_secret(code, salt)
        self.sms_confirmation_salt = salt
        code
      end

      def generate_sms_confirmation_code!
        code = generate_sms_confirmation_code
        save(validate: false)
        code
      end

      def code_is_correct? code
        return false if self.sms_confirmation_salt.nil? or self.sms_confirmation_code.nil?
        self.sms_confirmation_code == SCrypt::Engine.hash_secret(code, self.sms_confirmation_salt)
      end
      
    end
  end
end
