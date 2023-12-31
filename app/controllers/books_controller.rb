class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :register_page_view, only: [:show]

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
  end

  def index
    @book = Book.new
    favorite_count_sql = Favorite.select("count(*)").where("book_id = books.id and created_at > ?", 1.week.ago).to_sql
    @books = Book.all.select("*, (#{favorite_count_sql}) as favorite_count").order("favorite_count desc")
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render "index"
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body, tag_ids: [])
    end

    def ensure_correct_user
      @book = Book.find(params[:id])
      unless @book.user_id == current_user.id
        redirect_to books_path
      end
    end

    def register_page_view
      pv = PageView.new
      pv.path = request.fullpath
      pv.book_id = params[:id]
      pv.save!
    end
end
