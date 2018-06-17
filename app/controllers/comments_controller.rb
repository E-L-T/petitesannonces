class CommentsController < ApplicationController
  before_action :set_current_user
  
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = 'Comment was successfully created.'
      redirect_to advertisement_path params[:comment][:advertisement_id]
    else
      flash[:error] = 'Comment was not created.'
      redirect_to advertisements_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :advertisement_id)
  end
end
