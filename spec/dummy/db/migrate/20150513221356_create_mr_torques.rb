class CreateMrTorques < ActiveRecord::Migration
  def change
    create_table :mr_torques do |t|
      t.string :todays_quote

      t.timestamps
    end
  end
end
