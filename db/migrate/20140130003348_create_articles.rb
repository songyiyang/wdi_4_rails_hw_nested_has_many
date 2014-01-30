class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :body
      t.text :title
      t.references :user, index: true

      t.timestamps
    end
  end
end
