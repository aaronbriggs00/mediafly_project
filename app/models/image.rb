class Image < ApplicationRecord
  belongs_to :user
  has_one_attached :blob

  def fetch_mutation(options)
    Rails.cache.fetch([self, :image_variant], expires_in: 1.hour) do
      ImageMutator.call(self, **options)
    end
  end
end
