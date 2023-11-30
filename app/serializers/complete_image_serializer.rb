class CompleteImageSerializer < ActiveModel::Serializer
  attributes :id, :status, :download_url
  has_one :user

  def download_url
    if object.status == 'complete'
      object.fetch_url
    else
      null
    end
  end
end
