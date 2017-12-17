class Gsuite::Populate
  def self.run
    users = Gsuite.users.users
    users.each do |user|
      account = Account.find_by_gsuite_id(user.id)
      account ||= Account.new
        #pry user
        account.gsuite_id = user.id
        account.agreed_to_terms = user.agreed_to_terms
        account.creation_time = user.creation_time
        account.emails = user.emails
        account.is_admin = user.is_admin
        account.first_name = user.name.given_name
        account.last_name = user.name.family_name
        account.primary_email = user.primary_email
        account.suspended = user.suspended
        account.suspension_reason = user.suspension_reason
        account.thumbnail_photo_url = user.thumbnail_photo_url
        account.aliases = user.aliases
        account.is_mailbox_setup = user.is_mailbox_setup
      account.save!
    end
  end
end
