# frozen_string_literal: true

class AddRoleToAdminUsers < ActiveRecord::Migration[5.2]

  def change
    add_column :admin_users, :role, :string, default: '', null: false
  end

end
