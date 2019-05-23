# frozen_string_literal: true

class Share < ApplicationRecord

  CONTENT_TYPES = ['application/json', 'text/plain', 'text/html', 'text/markdown'].freeze

  validates :name, presence: true,
                   format: { with: %r{\A[-a-z0-9./]+\z}, message: 'Solo letras puntos y /' }
  validates :content_type, presence: true
  validates :content, presence: true
  belongs_to :previous, class_name: 'Share', optional: true

  after_create :publish

  def publish
    publish_content && mark_as_published
  end

  def publish_content
    metadata = { 'mime_type' => content_type }
    asset = Asset.find_or_initialize_by(name: name)
    asset.file_attacher.assign(StringIO.new(content), metadata: metadata)
    asset.save
  end

  def mark_as_published
    previous = Share.find_by(name: name, published: true)
    previous&.update(published: false)
    update(published: true, previous_id: previous&.id)
  end

end
