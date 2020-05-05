class ItemsController < ApplicationController
  before_action :find_item, only: [:edit, :update]

  def new
    @item = Item.new(list_id: params[:list_id])
  end

  def create
    @item = Item.new(item_params)
    @item.list_id = params[:list_id]
    if @item.save
      redirect_to list_path(@item.list)
    else
      flash[:errors] = @item.errors.full_messages
      redirect_to new_list_item_path
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to list_path(@item.list)
    else
      flash[:errors] = @item.errors.full_messages
      redirect_to edit_list_item_path(@item)
    end
  end

  private

  def item_params
    params.require(:item).permit(:content, :due_date, :priority, :assigned_user_id, :list_id)
  end

  def find_item
    @item = Item.find_by(id: params[:id])
  end
end
