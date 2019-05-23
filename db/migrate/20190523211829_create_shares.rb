# frozen_string_literal: true

class CreateShares < ActiveRecord::Migration[5.2]

  def change
    create_table :shares, id: :uuid do |t|
      t.string :name, null: false
      t.uuid :previous_id
      t.string :content_type
      t.text :content
      t.boolean :published, null: false, default: false
      t.timestamps
    end
  end

end
