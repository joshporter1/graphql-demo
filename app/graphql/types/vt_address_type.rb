Types::VTAddressType = GraphQL::ObjectType.define do
    name "VTAddress"

    field :ip_address, types.String, hash_key: 'ip_address'
    field :last_resolved, types.String, hash_key: 'last_resolved'

    field :asn, types.Int, hash_key: 'asn'
    field :as_owner, types.String, hash_key: 'as_owner'
    field :country, types.String, hash_key: 'country'


    field :resolutions, types[Types::VTDomainType] do
      argument :pivot, types.Boolean, default_value: false
      description "Pivotable Domain Resolutions"
      resolve ->(obj, args, ctx) {
        obj['resolutions'].map do |res|
          if args['pivot']
            res.merge! Uirusu::VTDomain.query_report(VTAPI, res['hostname'])
          end
          res
        end
      }
    end
    
    field :urls, types[Types::VTUrlType] do
      argument :pivot, types.Boolean, default_value: false
      description "Pivotable URLs"
      resolve ->(obj, args, ctx) {
        obj['detected_urls'].map do |res|
          if args['pivot']
            res.merge! Uirusu::VTUrl.query_report(VTAPI, res['url'], allinfo: 1)
          end
          res
        end
      }
    end

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

    field :raw, types.String do
      description "Response as raw JSON"
      resolve ->(obj, args, ctx) {
        obj.to_json
      }
    end
  end
