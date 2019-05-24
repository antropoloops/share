# frozen_string_literal: true

##
# ==SCHEMA==
# string "name", null: false
# uuid "previous_id"
# string "content_type"
# text "content"
# boolean "published", default: false, null: false
# datetime "created_at", null: false
# datetime "updated_at", null: false
class Share < ApplicationRecord

  CONTENT_TYPES = ['application/json', 'text/plain', 'text/html', 'text/markdown'].freeze

  validates :name, presence: true,
                   format: { with: %r{\A[-a-z0-9./]+\z}, message: 'Solo letras puntos y /' }
  validates :content_type, presence: true
  validates :content, presence: true
  belongs_to :previous, class_name: 'Share', optional: true

  after_create :publish

  def publish
    asset = publish_content
    asset && mark_as_published
    asset
  end

  def publish_content
    metadata = { 'mime_type' => content_type, 'description': 'Audioset' }
    asset = Asset.find_or_initialize_by(name: name)
    asset.file_attacher.assign(StringIO.new(content), metadata: metadata)
    asset.save
    asset
  end

  def mark_as_published
    previous = Share.find_by(name: name, published: true)
    previous&.update(published: false)
    update!(published: true, previous_id: previous&.id)
  end

end
