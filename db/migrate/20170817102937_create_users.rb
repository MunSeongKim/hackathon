class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: false do |t|
      t.integer :id, null: false
      t.string :uid,  null: false
      t.string :name, null: false
      t.string :snstype, null: false
      t.timestamps null: false
    end
    add_index :users, :uid, unique: true
  end
end
