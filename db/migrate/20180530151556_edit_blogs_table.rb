class EditBlogsTable < ActiveRecord::Migration[5.2]
  def change
    change_table :blogs do |b|
      b.integer :user_id
    end
  end
end
