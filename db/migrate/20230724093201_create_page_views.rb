class CreatePageViews < ActiveRecord::Migration[6.1]
  def change
    create_table :page_views do |t|
      t.string :path
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
  end
end
