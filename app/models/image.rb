class Image < ApplicationRecord
  belongs_to :user
  has_one_attached :blob

  def fetch_url
    @fetch_url ||= self.blob.url
  end
end
