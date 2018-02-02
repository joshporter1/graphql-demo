Types::VTUrlType = GraphQL::ObjectType.define do
    name "VTUrl"

    field :url, types.String, hash_key: 'url'
    field :scan_date, types.String, hash_key: 'scan_date'
    field :first_seen, types.String, hash_key: 'first_seen'
    field :last_seen, types.String, hash_key: 'last_seen'

    field :categories, types[types.String] do
      resolve ->(obj, args, ctx) {
        obj['additional_info']['categories']
      }
    end

    field :scans, types[Types::VTScanType] do
      resolve ->(obj, args, ctx) {
        obj['scans'].map do |k, res|
          res['vendor'] = k
          res
        end
      }
    end

    field :resolution, Types::VTAddressType do
      argument :pivot, types.Boolean, default_value: false
      description "Pivotable IP Resolutions"
      resolve ->(obj, args, ctx) {
        res = {"ip_address" => obj['additional_info']['resolution']}
        if args['pivot']
          res.merge! Uirusu::VTIPAddr.query_report(VTAPI, res['ip_address'])
        end
        res
      }
    end

    field :detection_ratio, types.String do
      description "Computed detection ratio"
      resolve ->(obj, args, ctx) {
        "#{obj['positives']}/#{obj['total']}"
      }
    end

    field :raw, types.String do
      description "Response as raw JSON"
      resolve ->(obj, args, ctx) {
        obj.to_json
      }
    end
  end
