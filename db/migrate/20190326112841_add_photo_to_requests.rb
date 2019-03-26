class AddPhotoToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :photo, :string
  end
end
