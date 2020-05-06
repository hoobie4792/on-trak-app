class ItemsController < ApplicationController
  before_action :find_item, only: [:edit, :update, :destroy]

  def new
    @item = Item.new(list_id: params[:list_id])
  end

  def create
    @item = Item.new(item_params)
    @item.list_id = params[:list_id]
    if @item.save
      category_ids = params[:item][:category_ids].reject { |c| c.empty? }
      @item.set_categories(category_ids)
      redirect_to list_path(@item.list)
    else
      flash[:errors] = @item.errors.full_messages
      redirect_to new_list_item_path
    end
  end

  def edit
  end

  def update
    category_ids = params[:item][:category_ids].reject { |c| c.empty? }
    @item.set_categories(category_ids)
    if @item.update(item_params)
      redirect_to list_path(@item.list)
    else
      flash[:errors] = @item.errors.full_messages
      redirect_to edit_list_item_path(@item)
    end
  end

  def destroy
    @list = @item.list
    @item.destroy
    redirect_to list_path(@list)
  end

  private

  def item_params
    params.require(:item).permit(:content, :due_date, :priority, :assigned_user_id, :list_id, :category_ids)
  end

  def find_item
    if params[:id]
      @item = Item.find_by(id: params[:id])
    end
    if params[:item_id]
      @item = Item.find_by(id: params[:item_id])
    end
  end
end
