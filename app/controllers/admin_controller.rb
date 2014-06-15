class AdminController < ApplicationController

  before_action :authenticate_member!
  before_action :is_admin

  def index
    @members = Member.all
    @posts = Post.all
    @comments = Comment.all
  end

  private

  def is_admin
    unless current_member.role == 1
      redirect_to "/errors/admin_error"
    end
  end

end
