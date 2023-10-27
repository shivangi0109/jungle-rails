class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|
      t.string :name
      t.date :starts_on
      t.date :ends_on
      t.integer :percent_off

      t.timestamps
    end
  end
end
