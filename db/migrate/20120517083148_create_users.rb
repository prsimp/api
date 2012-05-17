class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :age
      t.string :email
      t.string :location
      t.string :name
      t.string :username

      t.timestamps
    end

    add_index :users, :username
  end
end
