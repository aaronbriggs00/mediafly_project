class Image < ApplicationRecord
  belongs_to :user
  has_one_attached :blob

  def fetch_url
    if self.status == "complete"
      @fetch_url ||= self.blob.url
    end
  end

  def fetch_filename
    @fetch_filename ||= self.blob.filename
  end
end
