class CreateInscricaos < ActiveRecord::Migration[7.1]
  def change
    create_table :inscricoes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :evento, null: false, foreign_key: true

      t.timestamps
    end
  end
end
