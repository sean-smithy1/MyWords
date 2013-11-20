FactoryGirl.define do

  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :list do
    user_id 1
    listname "PlaceHolder"
    listtype "u"
    after (:create) do |list|
      6.times {list.words << FactoryGirl.create(:word)}
    end
  end

  factory :word do
    sequence(:word) { |n| "#{n}_Word"}
  end

end
