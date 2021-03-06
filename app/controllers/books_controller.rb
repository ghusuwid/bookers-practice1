class BooksController < ApplicationController
    before_action :correct_user, only: [:edit ]
    def show
        
        @book_new = Book.new
        @book = Book.find(params[:id])
        @post_comment = PostComment.new
        
    end
    
    def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        if@book.save
        redirect_to book_path(@book)
        flash[:notice] = "you have created book successfully" 
        else
        @books = Book.all
        render :index
        end
    end
    
    def index
        @book = Book.new
        
        @books = Book.all
    end
    
    def edit
        @book = Book.find(params[:id])
    end
    
    def update
        book = Book.find(params[:id])
        if book.update(book_params)
        redirect_to book_path(book)
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
    
    def user_params
       params.require(:user).permit(:name, :introduction, :profile_image)
    end
    
    def correct_user
      @book = Book.find(params[:id])
      redirect_to books_path unless @book.user == current_user
    end
    
end
