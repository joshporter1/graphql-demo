Types::VTScanType = GraphQL::ObjectType.define do
    name "VTScan"

    field :vendor, types.String, hash_key: 'vendor'
    field :detected, types.String, hash_key: 'detected'
    field :result, types.String, hash_key: 'result'
  end
