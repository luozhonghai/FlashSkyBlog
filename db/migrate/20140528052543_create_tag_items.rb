class CreateTagItems < ActiveRecord::Migration
  def change
    create_table :tag_items do |t|
      t.references :tag, index: true
      t.references :article, index: true

      t.timestamps
    end
  end
end
