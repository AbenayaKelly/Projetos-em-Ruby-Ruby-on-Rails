class CreateEventos < ActiveRecord::Migration[7.1]
  def change
    create_table :eventos do |t|
      t.string :nome
      t.text :descricao
      t.date :data

      t.timestamps
    end
  end
end
