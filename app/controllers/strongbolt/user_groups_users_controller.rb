module StrongBolt
  class UserGroupsUsersController < StrongBoltController

    self.model_for_authorization = "UserGroup"

    def create
      @user_group = UserGroup.find(params[:user_group_id])
      @user = StrongBolt.user_class.find(params[:id])
      
      @user_group.users << @user unless @user_group.users.include?(@user)

      redirect_to request.referrer || user_group_path(@user_group)
    end

    def destroy
      @user_group = UserGroup.find(params[:user_group_id])
      @user = StrongBolt.user_class.find(params[:id])
      
      @user_group.users.delete @user

      redirect_to request.referrer || user_group_path(@user_group)
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      if @user_group.nil?
        flash[:danger] = "User Group ##{params[:user_group_id]} does not exist"
        redirect_to user_groups_path
      else
        flash[:danger] = "User ##{params[:id]} does not exist"
        redirect_to user_group_path(@user_group)
      end
    end

  end
end