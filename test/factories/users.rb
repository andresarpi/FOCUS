FactoryGirl.define do
  factory :user do
    name "Andres Arpi"
    email "aarpi@itba.edu.ar"
    password "Invol2ver"
  end
  
  factory :passwordlessUser, class: User do
    name "MyString"
    email "MyString"
    password "    "
  end
end
