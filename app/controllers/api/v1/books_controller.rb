module Api
  module V1
    class BooksController < ApplicationController
      def index
        books = Book.all

        render json: BooksRepresenter.new(books).as_json
      end

      def create
        book = Book.new(book_params)

        if book.save
          render json: book, status: :created
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      def destroy
        Book.find(params[:id]).destroy!

        head :no_content
      end

      def update
        book = Book.find(params[:id])

        if book.update(book_params)
          render json: book, status: :ok
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      def show
        book = Book.find(params[:id])
        render json: book
      end

      private

      def book_params
        params.require(:book).permit(:title, :author, :genre, :current_page, :total_pages)
      end
    end
  end
end
