class CreateBlogapp < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |u|
      u.string :name
      u.string :password
      u.string :birthdate
    end
    create_table :blogs do |b|
      b.string :title
      b.string :content
      b.string :date
    end
  end
end
