# frozen_string_literal: true

class AddPublishPathToAudioset < ActiveRecord::Migration[5.2]

  def change
    add_column :audiosets, :publish_path, :string
  end

end
