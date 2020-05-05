class ListsController < ApplicationController
  before_action :find_list, only: [:show, :edit, :update, :search_user, :add_user]

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

  def search_user
    if params[:query]
      @users = User.search(params[:query])
    else
      @users = nil
    end
  end

  def add_user
    @user = User.find_by(id: params[:user_id])
    if @user
      UserList.create(list: @list, user: @user)
    end
    redirect_to list_search_user_path(@list)
  end

  private

  def list_params
    params.require(:list).permit(:name, :due_date)
  end

  def find_list
    if params[:id]
      @list = List.find_by(id: params[:id])
    end
    if params[:list_id]
      @list = List.find_by(id: params[:list_id])
    end
  end

end
