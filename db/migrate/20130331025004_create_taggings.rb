class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :post_id
      t.integer :tag_id

      t.timestamps
    end
    add_index :taggings, [:post_id, :tag_id]
  end
end
