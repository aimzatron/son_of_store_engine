FactoryGirl.define do

  sequence :email do |n|
    "person#{n}@test.com"
  end

  sequence :name do |n|
    "unique_store_#{n}"
  end

  sequence :path do |n|
    "unique_store_#{n}"
  end

  factory :store do
    name
    description "This is a description"
    path
    status "live"
  end

  factory :product do
    name "product_name"
    description "a_description"
    price 2.00
    retired false 
    store
  end 

  factory :product_2, class: Product do 
    name "product_name"
    description "a_description"
    price 2.00
    retired false 
    store
  end 


  factory :category do
    name "new category"
  end

  factory :user do
    full_name "user"
    email
    role "user"
    password "password"
  end

  factory :super_admin, class: User do
    full_name "user"
    email "test@test.com"
    role "platform_admin"
    password "password"
  end

  factory :admin, class: User do
    full_name "a name"
    email "test2@test.com"
    role "admin"
    password "password"
    store
  end

  factory :order do
    user
    status 'pending'
    total_cost 500
    card_number '4242424242424242'
  end

  factory :session do 
  end

  factory :cart do
    store
    session
  end

  factory :cart_2, class: Cart do
    store
    session 
  end

  factory :line_item do
    product
    cart
  end

  factory :billing_address, class: CustomerAddress do
    street_name "Mallory Lane"
    city "Denver"
    state "Colorado"
    zipcode "80204"
    address_type "billing"
  end

   factory :shipping_address, class: CustomerAddress do
    street_name "Mallory Lane"
    city "Denver"
    state "Colorado"
    zipcode "80204"
    address_type "shipping"
  end
end




