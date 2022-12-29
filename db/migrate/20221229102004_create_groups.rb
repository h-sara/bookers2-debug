class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name #グループ名
      t.string :introduction #グループの紹介文
      t.integer :image_id #グループ画像
      t.integer :owner_id #グループ作成者がグループオーナーになる

      t.timestamps
    end
  end
end