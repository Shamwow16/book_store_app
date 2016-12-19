class BooksController < ApplicationController
  before_action :require_signin
  before_action :require_admin
  before_action :set_book, except: [:index,:new,:create]

  def index
    @books = Book.all
  end

  def show
  end

  def new
    @book = Book.new
    @publishers = Publisher.all
    @authors = Author.all
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      flash[:success] = "Book has been created"
      redirect_to @book
    else
      flash.now[:danger] = "Book has not been created"
      @publishers = Publisher.all
      @authors = Author.all
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update_attributes(book_params)
      flash[:success] = "Book has been updated"
      redirect_to @book
    else
      flash.now[:danger] = "Book has not been updated"
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = "Book has been deleted"
      redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :book_cover, :price, :isbn, :page_count, :description, :published_at, :publisher_id, author_ids: [])
  end

  def set_book
    @book = Book.find(params[:id])
  end

end
