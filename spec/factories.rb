FactoryGirl.define do

  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :lists_word do
    association :list
    association :word
  end

  factory :list do
    user_id 1
    listname "PlaceHolder"
    listtype "u"

    factory :list_with_words do
      ignore do
        words_count 6
      end
      after (:create) do |list, evaluator|
        FactoryGirl.create_list(:lists_word, evaluator.words_count, list: list)
      end
    end
  end

   factory :word do
    sequence(:word) { |n| "#{n}_Word" }
  end

end
