# frozen_string_literal: true

class ClipAddCover2 < ActiveRecord::Migration[5.2]

  def change
    add_column :clips, :cover2_data, :jsonb
  end

end
