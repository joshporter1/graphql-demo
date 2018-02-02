Types::VTDomainType = GraphQL::ObjectType.define do
    name "VTDomain"

    field :categories, types[types.String], hash_key: 'categories'
    field :whois, types.String, hash_key: 'whois'

    field :samples, types[types.String] do
      resolve ->(obj, args, ctx) {
        obj.select{|key| key.match(/.*_samples/) }.values.flatten.map { |e| e['sha256'] }.uniq
      }
    end

    field :resolutions, types[Types::VTAddressType] do
      argument :pivot, types.Boolean, default_value: false
      resolve ->(obj, args, ctx) {
        obj['resolutions'].map do |res|
          if args['pivot']
            Uirusu::VTIPAddr.query_report(VTAPI, res['ip_address'])
          else
            res
          end
        end
      }
    end

    field :raw, types.String do
      resolve ->(obj, args, ctx) {
        obj
      }
    end
  end
