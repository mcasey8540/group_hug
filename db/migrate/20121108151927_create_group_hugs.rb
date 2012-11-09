require_relative '../config'

class CreateGroupHugs < ActiveRecord::Migration
  def change
    create_table :group_hugs do |t|
      t.string :confession_id
      t.string :confession_text

      t.timestamps
    end
  end

end