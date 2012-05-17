class CreateFacts < ActiveRecord::Migration
  def change
    create_table :facts do |t|
      t.integer :user_id
      t.string :body
      t.string :fact_type
      t.string :title

      t.timestamps
    end

    add_index :facts, :user_id
  end
end
