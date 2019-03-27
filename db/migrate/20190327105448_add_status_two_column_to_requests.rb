class AddStatusTwoColumnToRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :status_two, :string
  end
end
