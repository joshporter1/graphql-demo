Types::VTFileType = GraphQL::ObjectType.define do
  name "VTFile"

  field :md5, types.String, hash_key: 'md5'
  field :sha1, types.String, hash_key: 'sha1'
  field :sha256, types.String, hash_key: 'sha256'
  field :date, types.String, hash_key: 'date'
  field :first_seen, types.String, hash_key: 'first_seen'
  field :last_seen, types.String, hash_key: 'last_seen'
  field :size, types.Int, hash_key: 'size'
  field :community_reputation, types.String, hash_key: 'community_reputation'
  field :malicious_votes, types.String, hash_key: 'malicious_votes'
  field :submission_names, types[types.String], hash_key: 'submission_names'
  field :itw_urls, types[types.String], hash_key: 'ITW_urls'

  field :categories, types[types.String] do
    resolve ->(obj, args, ctx) {
      obj['additional_info']['categories']
    }
  end

  field :detection_ratio, types.String do
    description "Computed detection ratio"
    resolve ->(obj, args, ctx) {
      "#{obj['positives']}/#{obj['total']}"
    }
  end

  field :domains, types[Types::VTDomainType] do
    argument :pivot, types.Boolean, default_value: false
    description "Pivoted domains parsed from URLs"
    resolve ->(obj, args, ctx) {
      obj['ITW_urls'].map do |url|
        begin
          domain = URI.parse(URI.encode(url)).host
          res = {
            'hostname' => domain
          }
          if args['pivot']
            res.merge! Uirusu::VTUrl.query_report(VTAPI, domain)
          end
          res
        rescue URI::InvalidURIError => e
          STDERR.puts e
        end
      end
    }
  end

  field :urls, types[Types::VTUrlType] do
    argument :pivot, types.Boolean, default_value: false
    description "Pivoted URLs"
    resolve ->(obj, args, ctx) {
      obj['ITW_urls'].map do |url|
        res = {
          'url' => url
        }
        if args['pivot']
          Uirusu::VTUrl.query_report(VTAPI, url, allinfo: 1)
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
