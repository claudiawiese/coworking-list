class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.datetime :date
      t.string :client_first_name
      t.string :client_last_name
      t.string :email
      t.string :phone
      t.text :bio
      t.string :status

      t.timestamps
    end
  end
end
