Types::VTUrlType = GraphQL::ObjectType.define do
    name "VTUrl"

    field :url, types.String, hash_key: 'url'
    field :domain, types.String, hash_key: 'domain'
    field :first_seen, types.String, hash_key: 'first_seen'
    field :last_seen, types.String, hash_key: 'last_seen'

    field :detection_ratio, types.String do
      resolve ->(obj, args, ctx) {
        "#{obj['positives']}/#{obj['total']}"
      }
    end

    field :raw, types.String do
      resolve ->(obj, args, ctx) {
        obj
      }
    end
  end
