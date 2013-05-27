FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end

factory :list do
    sequence(:user_id) { 1 }
    sequence(:listname)  { |n| "List #{n}" }
    sequence(:listtype) { "u" }
    end

  end
end

