Warden::Manager.after_authentication do |user, auth, options|
  if user.respond_to? :confirmation_required?
    if auth.session(options[:scope])[:need_sms_confirmation] = user.confirmation_required?
      user.send_confirmation_instructions
    end
  end
end
