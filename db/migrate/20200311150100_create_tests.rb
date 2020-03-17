class CreateTests < ActiveRecord::Migration[6.0]
  def change
    create_table :tests do |t|
      t.string :name,           null: false, limit: 255
      t.text :description

      t.timestamps
    end
  end
end
