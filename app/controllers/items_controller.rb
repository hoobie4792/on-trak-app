class ItemsController < ApplicationController
  before_action :find_item, only: [:edit, :update]

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to list_path(@item.list)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to list_path(@item.list)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:content, :due_date, :priority, :assigned_user)
  end

  def find_item
    @item = Item.find_by(id: params[:id])
  end
end
