class AddProfileImageIdToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :image_id, :string
    add_column :books, :profile_image_id, :string
  end
end
