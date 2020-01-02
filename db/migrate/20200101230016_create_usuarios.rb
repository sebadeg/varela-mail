class CreateUsuarios < ActiveRecord::Migration[5.2]
  def change
    create_table :usuarios do |t|
      t.string :email
      t.string :password
      t.string :token

      t.timestamps
    end
  end
end
