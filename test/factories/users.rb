FactoryGirl.define do
  factory :user do
    name "Andres Arpi"
    email "aarpi@itba.edu.ar"
    password "Invol2ver"
  end

  factory :userbis, class: User do
    name "Lionel Messi"
    email "lionel@messi.edu.ar"
    password "Argentina"
  end
  
  factory :passwordlessUser, class: User do
    name "MyString"
    email "MyString"
    password "    "
  end
end
