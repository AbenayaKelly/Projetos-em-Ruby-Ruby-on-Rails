class CreateParticipantes < ActiveRecord::Migration[7.1]
  def change
    create_table :participantes do |t|
      t.string :nome
      t.string :email
      t.references :evento, null: false, foreign_key: true

      t.timestamps
    end
  end
end
