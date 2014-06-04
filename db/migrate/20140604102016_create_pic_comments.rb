class CreatePicComments < ActiveRecord::Migration
  def change
    create_table :pic_comments do |t|
      t.string :user_name
      t.string :description
      t.references :user, index: true
      t.references :picture, index: true

      t.timestamps
    end
  end
end
