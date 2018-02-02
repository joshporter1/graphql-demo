Types::VTDomainType = GraphQL::ObjectType.define do
    name "VTDomain"

    field :hostname, types.String, hash_key: 'hostname'
    field :last_resolved, types.String, hash_key: 'last_resolved'

    field :whois, types.String, hash_key: 'whois'
    field :whois_timestamp, types.String, hash_key: 'whois_timestamp'
    field :categories, types[types.String], hash_key: 'categories'
    field :subdomains, types[types.String], hash_key: 'subdomains'

    field :samples, types[Types::VTFileType] do
      argument :pivot, types.Boolean, default_value: false
      description "Pivotable file samples"
      resolve ->(obj, args, ctx) {
        obj.select{|key| key.match(/.*_samples/) }.values.flatten.map do |res|
          if args['pivot']
            res.merge! Uirusu::VTFile.query_report(VTAPI, res['sha256'], allinfo: 1)
          end
          res
        end
      }
    end

    field :resolutions, types[Types::VTAddressType] do
      description "Pivotable IP Resolutions"
      argument :pivot, types.Boolean, default_value: false
      resolve ->(obj, args, ctx) {
        obj['resolutions'].map do |res|
          if args['pivot']
            res.merge! Uirusu::VTIPAddr.query_report(VTAPI, res['ip_address'])
          end
          res
        end
      }
    end

    field :raw, types.String do
      description "Response as raw JSON"
      resolve ->(obj, args, ctx) {
        obj.to_json
      }
    end
  end
