class ListsController < ApplicationController
  before_action :find_list, only: [:show, :edit, :update, :destroy, :update_members, :add_member, :remove_member, :add_group]

  def show
    @items = @list.sort_list_by(params[:option], params[:criteria])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.add_group(params[:list][:group_id], current_user)
    if @list.save
      UserList.create(user: current_user, list: @list) if !(@list.users.include? current_user)
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

  def destroy
    @list.destroy
    redirect_to user_path(current_user)
  end

  def update_members
    if params[:query]
      @users = User.search(params[:query])
    else
      @users = nil
    end
  end

  def add_member
    @user = User.find_by(id: params[:user_id])
    if @user
      UserList.create(list: @list, user: @user)
    end
    redirect_to list_update_members_path(@list)
  end

  def remove_member
    @user = User.find_by(id: params[:user_id])
    if @user
      @ul = UserList.find_by(list: @list, user: @user)
      if @ul
        @ul.destroy
      end
    end
    redirect_to list_update_members_path(@list)
  end

  def add_group
    @list.add_group(params[:group_id], current_user)
    redirect_to list_update_members_path
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
