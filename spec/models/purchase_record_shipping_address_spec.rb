require 'rails_helper'

RSpec.describe PurchaseRecordShippingAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user_id: user.id)
    @purchase_record_shipping_address = FactoryBot.build(:purchase_record_shipping_address, user_id: user.id, item_id: item.id)
    sleep 0.5
  end
  describe '発送先の作成' do
    context '内容に問題がない場合' do
      it '全て正常' do
        expect(@purchase_record_shipping_address).to be_valid
      end
      it 'building_name:任意' do
        @purchase_record_shipping_address.building_name = ''
        expect(@purchase_record_shipping_address).to be_valid
      end
    end
    context '内容に問題がある場合' do

      it "tokenが空では登録できないこと" do
        @purchase_record_shipping_address.token = nil
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'post_code:必須' do
        @purchase_record_shipping_address.post_code = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_code:「3桁ハイフン4桁」の半角文字列のみ保存可能' do
        @purchase_record_shipping_address.post_code = '1234567'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it 'prefecture_id:必須' do
        @purchase_record_shipping_address.prefecture_id = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'city:必須' do
        @purchase_record_shipping_address.city = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("City can't be blank")
      end
      it 'address:必須' do
        @purchase_record_shipping_address.address = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_number:必須' do
        @purchase_record_shipping_address.phone_number = '' 
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_number:10桁以上11桁以内の-ハイフンなし、半角数値のみ保存可能なこと' do
        @purchase_record_shipping_address.phone_number = '123456789234'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end
    end
  end
end