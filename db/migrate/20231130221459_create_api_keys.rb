class CreateApiKeys < ActiveRecord::Migration[7.1]
  def change
    create_table :api_keys do |t|
      t.string :token_digest, null: false

      t.timestamps
    end

    add_index :api_keys, :token_digest, unique: true
  end
end
