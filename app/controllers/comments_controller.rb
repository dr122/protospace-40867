class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = @prototype.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @prototype
    else
      @comments = @prototype.comments.reload
      render 'prototypes/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end