class AddAudioOggDataToClips < ActiveRecord::Migration[5.2]
  def change
    add_column :clips, :audio_ogg_data, :jsonb
  end
end
