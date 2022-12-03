class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id #フォローしたユーザのID
      t.integer :followed_id #フォローされたユーザのID
      t.timestamps
    end
  end
end
