FactoryGirl.define do
  factory :account do
    agreed_to_terms false
    creation_time "2017-12-16 18:58:21"
    emails ""
    gsuite_id "MyString"
    is_admin false
    first_name "MyString"
    last_name "MyString"
    primary_email "MyString"
    suspended false
    suspension_reason "MyString"
    thumbnail_photo_url "MyString"
    aliases ""
    is_mailbox_setup "MyString"
  end
  factory :user do
    
  end
end
