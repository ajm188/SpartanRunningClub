class FollowingsController < ApplicationController
  before_filter :set_following, only: [:destroy]

  def create
    @following = Following.new(following_params)
    respond_to do |format|
      if @following.save
        flash[:notice] =
          "You are now following this #{@following.followable_type}"
      else
        flash[:error] = 
          "An error occurred while trying to create a following for this "
        flash[:error] << "#{@following.followable_type}"
      end
      format.js do
        @updates = {
          "follow_unfollow" =>
            { partial: 'followings/follow_unfollow_button',
              locals: { followable: @following.followable } }
        }
        render 'shared/update'
      end
    end
  end

  def destroy
    if @following.destroy
      flash[:notice] =
        "You are no longer following this #{@following.followable_type}"
    end
    respond_to do |format|
      format.js do
        @updates = {
          "follow_unfollow" =>
            { partial: 'followings/follow_unfollow_button',
              locals: { followable: @following.followable } }
        }
        render 'shared/update'
      end
    end
  end

  private

  def set_following
    @following = Following.find(params[:id]) if params[:id]
  end

  def following_params
    params.require(:following)
      .permit(:member_id, :followable_id, :followable_type)
  end
end
