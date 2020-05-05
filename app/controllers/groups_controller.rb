class GroupsController < ApplicationController

  before_action :find_group, only: [:show, :edit, :update, :destroy, :update_members, :add_member, :remove_member]

    def index 
        @groups = Group.all
    end 

    def show
      
    end

    def new
        @group = Group.new
        @user = current_user
    end

    def create
        @group = Group.new(group_params)
        if @group.save
            GroupUser.create(user: current_user, group: @group)
          redirect_to group_path(@group)
        else 
          render :new
        end
    end 
    
    def edit
      @user = current_user
    end

    def update
       if @group.update(group_params)
           redirect_to group_path(@group)
       else 
           render :edit
       end
    end

    def destroy
      byebug
      @group.destroy
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
        GroupUser.create(group: @group, user: @user)
      end
        
        redirect_to group_update_members_path(@group)
    end

    def remove_member
      @user = User.find_by(id: params[:user_id])
      if @user
        @gu = GroupUser.find_by(group: @group, user: @user)
        if @gu
          @gu.destroy
        end 
      end
      redirect_to group_update_members_path(@group)
    end
    
    private

    def find_group
      if params[:id] 
      @group = Group.find_by(id: params[:id])
      end 
      if params[:group_id]
        @group = Group.find_by(id: params[:group_id])
      end 
    end

    def group_params
        params.require(:group).permit(:name)
    end

end

