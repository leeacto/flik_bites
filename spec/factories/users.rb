FactoryGirl.define do
  factory :user do |f|
    f.first_name             'first'
    f.last_name             'last'
    f.zipcode               '60060'
    f.username               'username'
    f.email                 "email@email.com"
    f.is_active              true
    f.password               "password"
  end
end
