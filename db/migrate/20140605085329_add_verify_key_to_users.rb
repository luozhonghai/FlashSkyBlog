class AddVerifyKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :verify_key, :string
  end
end
