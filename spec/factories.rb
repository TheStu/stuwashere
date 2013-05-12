FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobarfoobar"
    password_confirmation "foobarfoobar"
  end

  factory :trip do
    name "Lorem Trip"
    intro "Lorem Ipsum"
    start_date "22-05-2013"
    end_date "28-05-2013"
  end

  factory :gear_list do
    intro "Lorem ipsum"

    factory :gear_list_with_trip do
      trip
    end
  end

  factory :gear_listing do
    gear_list
    gear_item
    quantity 1
    group_type "Carrying"
  end

  factory :gear_item do
    name "Lorem Gear Item"
    intro "Lorem ipsum"
    weight 800
  end

  factory :post do
    title "Lorem Post"
    content "Lorem Ipsum"
    factory :post_with_gear_item do
      gear_item
    end
    factory :post_with_trip do
      trip
    end
  end

  factory :tag do
    name "Gear Review"
  end

  factory :tag_photo, class: Tag do
    name "Photo"
  end

  factory :tagging do
    post
    tag
  end

  factory :picture do
    description "Lorem Ipsum"
    name "Lorem Picture"
    flickr_small_url "http://farm9.staticflickr.com/8290/7741362602_bc48e007dd_s.jpg"
    flickr_medium_url "http://farm9.staticflickr.com/8290/7741362602_bc48e007dd.jpg"
    flickr_large_url "http://farm9.staticflickr.com/8290/7741362602_bc48e007dd_b.jpg"
    post
  end
end
