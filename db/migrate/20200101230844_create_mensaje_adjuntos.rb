class CreateMensajeAdjuntos < ActiveRecord::Migration[5.2]
  def change
    create_table :mensaje_adjuntos do |t|
      t.belongs_to :mensaje, foreign_key: true
      t.string :nombre
      t.binary :datos
      t.timestamps
    end
  end
end
