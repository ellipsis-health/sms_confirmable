module SmsConfirmable
  module Schema
    def sms_confirmation_hash
      apply_devise_schema :sms_confirmation_hash , String, :default => nil
    end

    def phone_confirmed_at
      apply_devise_schema :phone_confirmed_at , DateTime, :default => nil
    end

    def sms_confirmation_sent_at
      apply_devise_schema :sms_confirmation_sent_at , DateTime , :default => nil
    end

    def sms_confirmation_attempts
      apply_devise_schema :sms_confirmation_attempts, Integer, :default => 0
    end

  end
end
