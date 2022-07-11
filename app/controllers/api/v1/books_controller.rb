module Api
  module V1
    class BooksController < ApplicationController
      def index
        books = Book.all
        
        render json: BooksRepresenter.new(books).as_json
      end
      
      def create
        author = Author.create!(author_params)
        book = Book.new(book_params.merge(author_id: author.id))

        if book.save
          render json: BookRepresenter.new(book).as_json, status: :created
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

      def author_params
        params.require(:author).permit(:first_name, :last_name, :bio, :age, :publisher)
      end

      def book_params
        params.require(:book).permit(:title, :genre, :current_page, :total_pages)
      end
    end
  end
end
