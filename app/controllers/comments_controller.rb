class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]
  before_action :set_commenter_id, only: [:create]

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.js
      else
        format.js do
          flash[:error] = "Could not post comment."
          render 'shared/update'
        end
      end
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_commenter_id
    params[:comment][:commenter_id] = current_user.id if params[:comment]
  end

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.require(:comment).permit(:comment, :commentable_id,
      :commentable_type, :commenter_id)
  end
end
