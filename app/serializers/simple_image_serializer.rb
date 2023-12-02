class SimpleImageSerializer < ActiveModel::Serializer
  attributes :id, :status, :filename
  has_one :user

  def filename
    object.fetch_filename
  end
end