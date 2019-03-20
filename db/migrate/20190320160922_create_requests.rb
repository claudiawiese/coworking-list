class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.datetime :date
      t.string :status
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
