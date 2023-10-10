class CreateJwtDenyList < ActiveRecord::Migration[7.1]
  def change
    create_table :jwt_deny_lists do |t|
      t.string :jti, null: false
      t.datetime :exp, null: false

      t.timestamps
    end

    add_index :jwt_deny_lists, :jti
  end
end
