class CreateUserSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :user_sessions do |t|
      t.belongs_to :user, null: false
      t.string :token, null: false
      t.timestamps null: false
    end

    add_index :user_sessions, :token, unique: true
  end
end
