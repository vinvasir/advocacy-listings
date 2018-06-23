class SerializableOrganization < JSONAPI::Serializable::Resource
  type 'organizations'

  attributes :id, :title, :mission, :category_id, :live

  attribute :area_name do
    @object.area.name
  end
end