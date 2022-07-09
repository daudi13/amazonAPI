class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :current_page
      t.integer :total_pages

      t.timestamps
    end
  end
end
