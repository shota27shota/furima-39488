FactoryBot.define do
  factory :purchase_record_shipping_address do
    post_code { '123-4567' }
    prefecture_id { 1 }
    city { '東京都' }
    address { '1-1' }
    building_name { '東京ハイツ' }
    phone_number{ 10020003000 }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
