class PostsController < ApplicationController

  before_action :authenticate_member!

  def index
    @posts = Post.all
  end

  def create
    @post = current_member.posts.new(params.permit(:title,:content,:cate,:url))
    @post.save
  end

  def show
    @post = Post.find(params[:id])
    puts @post.member.email
  end
  
end
