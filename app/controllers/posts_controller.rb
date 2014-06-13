class PostsController < ApplicationController

  before_action :authenticate_member!

  def index
    @posts = Post.all
  end

  def create
    @post = current_member.posts.new(params.permit(:title,:content,:cate,:attachment_name,:attachment_url))
    @post.save
  end

  def show
    @post = Post.find(params[:id])
    @page_title = @post.title
  end

  def edit
    @post = current_member.posts.find(params[:id])
  end

  def update
    post = current_member.posts.find(params[:id])
    post.update_attributes(params.permit(:title,:content,:cate,:attachment_name,:attachment_url))
    redirect_to "/posts/#{post.id}"
  end
  
end
