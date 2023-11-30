class SimpleImageSerializer < ActiveModel::Serializer
  attributes :id, :status
  has_one :user
end