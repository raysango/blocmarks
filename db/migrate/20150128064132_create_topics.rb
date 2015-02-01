class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title, :unique => true
      t.references :user, index: true

      t.timestamps
    end
  end
end
