class PostsController < ApplicationController
  before_action :set_post, only: [:update]

  def index
    if params[:author_id]
      @posts = Author.find(params[:author_id]).posts
    else
      @posts = Post.all
    end
  end

  def show
    # FIXME: check that the author is valid, and post exists
    if params[:author_id]
      @post = Author.find(params[:author_id]).posts.find(params[:id])
    else
      set_post
    end
  end

  # check that the author is valid
  def new
    # check if an author with that id exeists
    if params[:author_id] && !Author.exists?(params[:author_id])
      redirect_to authors_path, alert: 'Author not found'
    else
      # associate the author with the post
      # if author_id is nil, this still works
      @post = Post.new(author_id: params[:author_id])
    end
  end

  def create
    # FIXME: check that the author_id is valid - ie the author exists
    @post = Post.new(post_params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post.update(params.require(:post))
    redirect_to post_path(@post)
  end

  # check that the author is valid
  def edit
    if params[:author_id]
      author = Author.find_by(id: params[:author_id])
      if author.nil?
        redirect_to authors_path, alert: "Author not found"
      else
        @post = author.posts.find_by(id: params[:id])
        redirect_to author_posts_path(author), alert: 'Post not found' if @post.nil?
      end
    else
      set_post
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

  def post_params
    params.require(:post).permit(:title, :description, :author_id)
  end
end
