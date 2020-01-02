class CreateMensajes < ActiveRecord::Migration[5.2]
  def change
    create_table :mensajes do |t|
      t.string :from
      t.string :from_password
      t.string :to
      t.string :bcc
      t.string :reply_to
      t.string :subject
      t.string :body
      t.string :header
      t.binary :header_data
      t.string :footer
      t.binary :footer_data
      t.boolean :sent
      t.timestamps
    end
  end
end
