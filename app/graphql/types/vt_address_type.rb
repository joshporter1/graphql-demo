Types::VTAddressType = GraphQL::ObjectType.define do
    name "VTAddress"

    field :ip_address, types.String, hash_key: 'ip_address'
    field :last_resolved, types.String, hash_key: 'last_resolved'

    field :asn, types.Int, hash_key: 'asn'
    field :as_owner, types.String, hash_key: 'as_owner'
    field :country, types.String, hash_key: 'country'

    field :resolutions, types[types.String] do
      resolve ->(obj, args, ctx) {
        obj['resolutions'].map {|res| res['hostname'] }
      }
    end

    field :resolutions, types[types.String] do
      argument :pivot, types.Boolean, default_value: false
      resolve ->(obj, args, ctx) {
        obj['resolutions'].map{ |res| res['ip_address'] } if args['pivot']
      }
    end

    field :raw, types.String do
      resolve ->(obj, args, ctx) {
        obj
      }
    end
  end
