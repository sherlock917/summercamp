class AdminController < ApplicationController

  before_action :authenticate_member!
  before_action :is_admin

  def index
    @members = Member.all
    @posts = Post.all
    @comments = Comment.all
  end

  def members
    @members = Member.all.desc(:created_at)
  end

  def posts
    @posts = Post.all.desc(:created_at)
  end

  def comments
    @comments = Comment.all.desc(:created_at)
  end

  def delete_post
    post = Post.find(params[:post_id])
    post.destroy
    redirect_to '/admin/posts'
  end

  private

  def is_admin
    unless current_member.role == 1
      redirect_to '/errors/admin_error'
    end
  end

end
