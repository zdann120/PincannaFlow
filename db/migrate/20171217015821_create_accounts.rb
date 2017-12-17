class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.boolean :agreed_to_terms
      t.datetime :creation_time
      t.jsonb :emails
      t.string :gsuite_id
      t.boolean :is_admin
      t.string :first_name
      t.string :last_name
      t.string :primary_email
      t.boolean :suspended
      t.string :suspension_reason
      t.string :thumbnail_photo_url
      t.string :aliases, array: true
      t.string :is_mailbox_setup

      t.timestamps
    end
    add_index :accounts, :gsuite_id, unique: true
  end
end
