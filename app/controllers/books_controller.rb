class BooksController < ApplicationController

  def index
    @user = current_user
    @book = Book.new
    @books = Book.page(params[:page])
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book)
    else
      render 'users/show'
    end
  end

  def show
    @user = current_user
    @book = Book.find(params[:id])
  end

  def edit
    @user = current_user
    @book = Book.find(params[:id])
  end

  def update
    @user = current_user
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(@book)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
