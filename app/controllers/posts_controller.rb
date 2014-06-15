class PostsController < ApplicationController

  before_action :authenticate_member!

  def index
    @posts = Post.all
  end

  def create
    @post = current_member.posts.new(params.permit(:title,:content,:cate,:attachments => []))
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
    post.update_attributes(params.permit(:title,:content))
    redirect_to "/posts/#{post.id}"
  end

  def delete
    unless current_member.role == 1
      @post = Post.find(params[:id])
      @post.destroy
      # code, result, response_headers = Qiniu::Storage.delete('scauhci', @item.qiniu_key)
    end
  end
  
end
