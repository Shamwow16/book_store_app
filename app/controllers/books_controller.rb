class BooksController < ApplicationController
  def index
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      flash[:success] = "Book has been created"
      redirect_to @book
    else
      flash[:danger] = "Book has not been created"
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      flash[:success] = "Book has been updated"
      redirect_to @book
    else
      flash[:danger] = "Book has not been updated"
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:success] = "Book has been deleted"
      redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :price, :isbn, :page_count, :description, :published_at, :publisher_id)
  end

end
