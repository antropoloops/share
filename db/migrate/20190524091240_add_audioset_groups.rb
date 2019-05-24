# frozen_string_literal: true

class AddAudiosetGroups < ActiveRecord::Migration[5.2]

  def change
    add_column :audiosets, :parent_id, :uuid
    add_column :audiosets, :audioset_type, :string
    add_column :audiosets, :children, :string
  end

end
