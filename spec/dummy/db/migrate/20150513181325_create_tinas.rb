class CreateTinas < ActiveRecord::Migration
  def change
    create_table :tinas do |t|
      t.integer :ladies
      t.integer :badonkadonks
      t.string  :mushy_snugglebites

      t.timestamps
    end
  end
end
