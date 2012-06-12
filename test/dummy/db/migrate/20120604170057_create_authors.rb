class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.boolean :status

      t.timestamps
    end
  end
end
