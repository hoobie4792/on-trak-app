class ListsController < ApplicationController
  before_action :find_list, only: [:show, :edit, :update]

  def show
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    byebug
    if @list.save
      UserList.create(user: current_user, list: @list)
      redirect_to user_path(current_user)
    else
      render :new
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
