module SmsConfirmable
  module Generators
    class SmsConfirmableGenerator < Rails::Generators::NamedBase
      namespace "sms_confirmable"

      desc "Adds :sms_confirmable to the given user model. Also creates an ActiveRecord migration for the same"

      def inject_sms_confirmable
        model_path = File.join('app','models',"#{file_path}.rb")
        inject_into_file(model_path, "sms_confirmable, :", after: 'devise :') if File.exists? model_path
      end
  
      hook_for :orm
    end
  end
end

