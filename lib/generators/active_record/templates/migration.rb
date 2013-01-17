class AddSmsConfirmableTo<%= table_name.camelize %> < ActiveRecord::Migration
  def change
    change_table :<%= table_name %> do |t|
      t.string :sms_confirmation_code, :default => nil
      t.string :sms_confirmation_salt, :default => nil
      t.datetime :confirmed_at, :default => nil
      t.datetime :confirmation_sent_at, :default => nil
      t.integer :sms_confirmation_attempts, :default => 0
    end
  end
end
