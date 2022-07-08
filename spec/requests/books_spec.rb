require 'rails_helper'

describe'Books API', type: :request do
  
  describe 'GET/books' do
    before do 
      FactoryBot.create(:book, title: 'Book 1', author: 'Author 1', genre: 'Genre 1', current_page: 1, total_pages: 100)
      FactoryBot.create(:book, title: 'Book 2', author: 'Author 2', genre: 'Genre 2', current_page: 2, total_pages: 100)
      FactoryBot.create(:book, title: 'Book 3', author: 'Author 3', genre: 'Genre 3', current_page: 3, total_pages: 100)
    end

    it 'returns all books' do
      get '/api/v1/books'
  
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'POST/books' do
    it 'creates a new book' do
      expect {
        post '/api/v1/books', params: { book: { title: 'Book 1', author: 'Author 1', genre: 'Genre 1', current_page: 1, total_pages: 100 } }
      }.to change { Book.count }.by(1)
  
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['title']).to eq('Book 1')
    end
  end

  describe 'DELETE /books/:id' do
    let!(:book) { FactoryBot.create(:book, title: 'Book 1', author: 'Author 1', genre: 'Genre 1', current_page: 1, total_pages: 100) }
    
    it 'deletes a specific book' do
      expect {
        delete "/api/v1/books/#{book.id}"
      }.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end