class CommentsController < ApplicationController

  before_action :authenticate_member!

  def create
    @comment = current_member.comments.new(params.permit(:post_id,:content))
    @comment.save
  end

end