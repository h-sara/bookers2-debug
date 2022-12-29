class CreateGroupUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :group_users do |t|
      t.integer :user_id, foreign_key: true #ユーザID
      t.integer :group_id, foreign_key: true #グループID

      t.timestamps
    end
  end
end