class CreateCoins < ActiveRecord::Migration[7.1]
  def change
    create_table :coins do |t|
      t.string :description
      t.string :acronym
      t.text :url_image

      t.timestamps
    end
  end
end
