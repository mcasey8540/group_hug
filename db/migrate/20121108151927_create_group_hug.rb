require_relative '../config'

class CreateGroupHug < ActiveRecord::Migration
  def change
    create_table :group_hug do |t|
      t.string :confession_id
      t.string :confession_text

      t.timestamps
    end
  end

end