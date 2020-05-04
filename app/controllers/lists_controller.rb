class ListsController < ApplicationController
  before_action :find_list, only: [:show, :edit, :update]

  def show
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      UserList.create(user: current_user, list: @list)
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @list.update(list_params)
      redirect_to list_path(@list)
    else
      render :edit
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :due_date)
  end

  def find_list
    @list = List.find_by(id: params[:id])
  end

end
