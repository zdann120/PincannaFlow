namespace :fetch_accounts do
  desc "This populates the database with current gsuite account info"
  task :populate do
    users = Gsuite.users.users
    users.each do |user|
      account = Account.first_or_initialize_by(gsuite_id: user.id) do |account|
        account.agreed_to_terms = user.agreed_to_terms
        account.creation_time = user.creation_time
        account.emails = user.emails
        account.is_admin = user.is_admin
        account.first_name = user.name.first_name
        account.last_name = user.name.family_name
        account.primary_email = user.primary_email
        account.suspended = user.suspended
        account.suspension_reason = user.suspension_reason
        account.thumbnail_photo_url = user.thumbnail_photo_url
        account.aliases = user.aliases
        account.is_mailbox_setup = user.is_mailbox_setup
        end.save!
    end
  end
end
