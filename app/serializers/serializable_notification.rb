class SerializableNotification < JSONAPI::Serializable::Resource
  type 'notifications'

  attributes :id, :action, :actor, :recipient, :notifiable, :read_at, :created_at
end