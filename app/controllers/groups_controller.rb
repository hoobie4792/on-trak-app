class GroupsController < ApplicationController

  before_action :found_group, only: [:show, :edit, :update, :delete]

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

    end

    def update
       if @group.update(group_params)
           redirect_to group_path(@group)
       else 
           render :edit
       end
    end

    private

    def found_group
        @group = Group.find_by(id: params[:id])
    end

    def group_params
        params.require(:group).permit(:name)
    end

end
