class PurchaseRecordsController < ApplicationController
  before_action :set_public_key, only: [:index, :create]
  before_action :sold
  before_action :authenticate_user!
  before_action :items_user

  def index
    @item = Item.find(params[:item_id])
    #= Item(モデル名).find(必要な情報を持ってくるメソッド) params[:item_id] ターミナルから適切なid名を見て記述する  
    @purchase_record_shipping_address = PurchaseRecordShippingAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_record_shipping_address = PurchaseRecordShippingAddress.new(purchase_record_params)
    if @purchase_record_shipping_address.valid?
      pay_item
      @purchase_record_shipping_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

    private

  def purchase_record_params
    params.require(:purchase_record_shipping_address).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: purchase_record_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def sold
    @item = Item.find(params[:item_id])
    if @item.purchase_record.present?
      redirect_to user_session_path
    end
  end

  def items_user
    if current_user.id == @item.user.id 
      redirect_to user_session_path
    end
  end

  def set_public_key
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

end
