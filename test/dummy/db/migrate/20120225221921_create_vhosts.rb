class CreateVhosts < ActiveRecord::Migration
  def change
    create_table :vhosts do |t|
      t.string :name
      t.string :domains

      t.timestamps
    end
  end
end
