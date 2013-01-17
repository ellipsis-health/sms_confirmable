module SmsConfirmable
  module Schema
    def sms_confirmation_code
      apply_devise_schema :sms_confirmation_code , String, :default => nil
    end

    def sms_confirmation_salt
      apply_devise_schema :sms_confirmation_salt , String, :default => nil
    end

    def confirmed_at
      apply_devise_schema :confirmed_at , DateTime, :default => nil
    end

    def confirmation_sent_at
      apply_devise_schema :confirmation_sent_at , DateTime , :default => nil
    end

    def confirmation_attempts
      apply_devise_schema :sms_confirmation_attempts, Integer, :default => 0
    end

  end
end
