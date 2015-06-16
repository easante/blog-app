class CommentsController < ApplicationController
  before_action :set_article
  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:success] = "Comment has been created"
      redirect_to @article
    else
      flash.now[:danger] = "Comment has not been created"
      render @article
    end
  end

private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
