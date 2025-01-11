class CommentsController < ApplicationController

  def create
    comment = Comment.new(comment_params)
    if comment.save
     redirect_to "/prototypes/#{comment.prototype.id}"
    else
      @prototype = Prototype.find(params[:id])
     render "prototypes/show", status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image ).merge(user_id: current_user.id)
  end

end