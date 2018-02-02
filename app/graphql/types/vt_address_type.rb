Types::VTAddressType = GraphQL::ObjectType.define do
    name "VTAddress"

    field :asn, types.String, hash_key: 'asn'
    field :as_owner, types.String, hash_key: 'as_owner'
    field :country, types.String, hash_key: 'country'

    field :resolutions, types[types.String] do
      resolve ->(obj, args, ctx) {
        obj['resolutions'].map {|res| res['hostname'] }
      }
    end

    field :raw, types.String do
      resolve ->(obj, args, ctx) {
        obj
      }
    end
  end
