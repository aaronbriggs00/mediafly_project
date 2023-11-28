class CreateImages < ActiveRecord::Migration[7.1]
  def change
    create_table :images do |t|
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end
