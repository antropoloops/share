# frozen_string_literal: true

class CreateBasicStructure < ActiveRecord::Migration[5.2]

  def change
    create_table :users, id: :uuid do |t|
      t.string :name, null: false
      t.string :locale, null: false, default: 'en'
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true

    create_table :spaces, id: :uuid do |t|
      t.string :name, null: false, uniqueness: true
      t.string :slug, null: false, uniqueness: true
      t.string :description
      t.jsonb :logo_data

      t.timestamps
    end

    create_table :memberships, id: :uuid do |t|
      t.references :space, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid
      t.string :level, null: false, default: 'read'
      t.timestamps
    end
    add_index :memberships, %i(space_id user_id), unique: true

    create_table :assets, id: :uuid do |t|
      t.references :space, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid
      t.text :description
      t.jsonb :file_data

      t.timestamps
    end

    create_table :audiosets, id: :uuid do |t|
      t.string :name, null: false, uniqueness: true
      t.string :slug, null: false, uniqueness: true
      t.string :readme

      t.timestamps
    end
    add_index :audiosets, :name, unique: true
  end

end
