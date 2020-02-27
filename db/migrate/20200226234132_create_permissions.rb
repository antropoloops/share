# frozen_string_literal: true

class CreatePermissions < ActiveRecord::Migration[5.2]

  def change
    create_table :permissions do |t|
      t.references :audioset, foreign_key: true, type: :uuid
      t.references :admin_user, foreign_key: true
      t.timestamps
    end
  end

end
