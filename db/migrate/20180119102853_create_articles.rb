class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.belongs_to :author, index: true
      t.string :name
      t.string :summary
      t.string :content
      t.timestamps
    end
  end
end
