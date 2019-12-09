class BooksController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

    def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        if @book.save
           flash[:notice] = "Book was successfully create."
           redirect_to book_path(@book)
        else
            @books = Book.all
            render :index
        end
    end

    def show
        @book = Book.new
        @book_detail = Book.find(params[:id])
    end

    def index
        @book = Book.new
        @books = Book.all
    end

    def edit
        @book = Book.find(params[:id])
    end

    def update
        @book = Book.find(params[:id])
        @book.user_id = current_user.id
        if @book.update(book_params)
           flash[:notice] = "Book was successfully update."
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
            params.require(:book).permit(:body, :title, :user_id)
        end

        def ensure_correct_user
            book = Book.find(params[:id])
            if current_user.id != book.user_id
               redirect_to books_path
            end
        end
    end
