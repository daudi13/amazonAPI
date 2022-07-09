FactoryBot.define do
  factory :author do
    first_name { 'MyString' }
    last_name { 'MyString' }
    bio { 'MyText' }
    age { 1 }
    publisher { 'MyString' }
  end
end
