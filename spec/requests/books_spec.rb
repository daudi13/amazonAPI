require 'rails_helper'

describe 'Books API', type: :request do
  describe 'GET /books' do
    before do
      FactoryBot.create(:author)
      FactoryBot.create(:author)
      FactoryBot.create(:author)
      FactoryBot.create(:book, title: 'Book 1', genre: 'Genre 1', current_page: 1, total_pages: 100, author_id: 1)
      FactoryBot.create(:book, title: 'Book 2', genre: 'Genre 2', current_page: 2, total_pages: 100, author_id: 2)
      FactoryBot.create(:book, title: 'Book 3', genre: 'Genre 3', current_page: 3, total_pages: 100, author_id: 3)
    end

    it 'returns all books' do
      get '/api/v1/books'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'POST /books' do
    it 'creates a new book' do
      expect do
        post '/api/v1/books',
            params: { book: { title: 'Book 1', genre: 'Genre 1', current_page: 1,
          total_pages: 100 }, author: { first_name: 'Author 1', last_name: 'Author 1', bio:'bio one', age: 44, publisher: 'publisher 1' } }
      end.to change { Book.count }.by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['title']).to eq('Book 1')
    end
  end

  describe 'DELETE /books' do
    let!(:book) do
      FactoryBot.create(:author)
      FactoryBot.create(:book, title: 'Book 1', genre: 'Genre 1', current_page: 1, total_pages: 100, author_id: 1)
    end

    it 'deletes a specific book' do
      expect do
        delete "/api/v1/books/#{book.id}"
      end.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'SHOW /books' do
    let!(:book) do
      FactoryBot.create(:author)
      FactoryBot.create(:book, title: 'Book 1', author_id: 1, genre: 'Genre 1', current_page: 1, total_pages: 100)
    end

    it 'returns a specific book' do
      get "/api/v1/books/#{book.id}"

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['title']).to eq('Book 1')
    end
  end

  describe '/books/id' do
    let!(:book) do
      FactoryBot.create(:author)
      FactoryBot.create(:book, title: 'Book 1', author_id: 1, genre: 'Genre 1', current_page: 1, total_pages: 100)
    end

    it 'updates a specific book' do
      put "/api/v1/books/#{book.id}",
          params: { book: { title: 'Book 2', author_id: 1 , genre: 'Genre 2', current_page: 2, total_pages: 100 } }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['title']).to eq('Book 2')
    end
  end
end
