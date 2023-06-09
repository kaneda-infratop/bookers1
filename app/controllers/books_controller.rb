class BooksController < ApplicationController
  def new
    @book=Book.new
  end

  def create
    @book=Book.new(book_params)
    if @book.save
       flash[:notice] = "successfully"
       redirect_to "/books/#{@book.id}"
    else
      render :new
    end

  end

  def index
    @books=Book.all
    @book=Book.new
  end

  def show
    @book=Book.find(params[:id])
  end

  def edit
    @book=Book.find(params[:id])
  end

  #def update
  #  @book=Book.find(params[:id])
  #  book = @book.update(book_params)
  #  if book.save
  #    flash[:notice] = "successfully"
  #    redirect_to "/books/#{book.id}"
  #  else
  #    render :edit
  #  end
  #end

  def update
    @book = Book.find(params[:id])
    if @book.title.blank? || @book.body.blank?
      flash.now[:alert] = "Title and body can't be blank"
      render :edit
    else
      if @book.update(book_params)
        redirect_to @book, notice: 'Book was successfully updated.'
      else
        render :edit
      end
    end
  end

  def destroy
    book=Book.find(params[:id])
    book.destroy
    flash[:notice] = "successfully"
    redirect_to "/books"
  end

 #エラー箇所ここから
  private
  def book_params
    params.require(:book).permit(:title,:body)
  end
end
