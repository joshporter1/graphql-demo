Types::VTHashType = GraphQL::ObjectType.define do
  name "VTHash"
  field :md5, types.String
  field :first_seen, types.String
  field :last_seen, types.String
  field :size, types.Int
end
