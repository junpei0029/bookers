class BooksController < ApplicationController

  def index
    @user = current_user
    @book = Book.new
    @books = Book.page(params[:page])
  end

  def create
    @user = current_user
    @books = Book.page(params[:page])
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book)
    else
      render 'users/show'
    end
  end

  def show
    @user = current_user
    @book = Book.find(params[:id])
    @new_book = Book.new
  end

  def edit
    @user = current_user
    @book = Book.where(user_id: @user.id).where(id: params[:id]).first
    redirect_to books_path if @book.blank?
  end

  def update
    @user = current_user
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book)
    else
      render :edit
    end
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
