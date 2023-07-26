class PurchaseRecordsController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    #= Item(モデル名).find(必要な情報を持ってくるメソッド) params[:item_id] ターミナルから適切なid名を見て記述する  
    @purchase_record_shipping_address = PurchaseRecordShippingAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_record_shipping_address = PurchaseRecordShippingAddress.new(purchase_record_params)
    if @purchase_record_shipping_address.valid?
      @purchase_record_shipping_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

    private

  def purchase_record_params
    params.require(:purchase_record_shipping_address).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: current_user.id)
  end
end
