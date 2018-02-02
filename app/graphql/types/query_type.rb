Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :vtfile do
    type Types::VTFileType
    argument :hash, !types.String
    description "VirusTotal Files"
    resolve ->(obj, args, ctx) {
      Uirusu::VTFile.query_report(VTAPI, args['hash'], allinfo: 1)
    }
  end

  field :vturl do
    type Types::VTUrlType
    argument :url, !types.String
    description "VirusTotal URLs"
    resolve ->(obj, args, ctx) {
      results = Uirusu::VTUrl.query_report(VTAPI, args['url'], allinfo: 1)
    }
  end

  field :vtaddress do
    type Types::VTAddressType
    argument :ip, !types.String
    description "VirusTotal IP Addresses"
    resolve ->(obj, args, ctx) {
      results = Uirusu::VTIPAddr.query_report(VTAPI, args['ip'])
    }
  end

  field :vtdomain do
    type Types::VTDomainType
    argument :domain, !types.String
    description "VirusTotal domains"
    resolve ->(obj, args, ctx) {
      results = Uirusu::VTDomain.query_report(VTAPI, args['domain'])
    }
  end
end
