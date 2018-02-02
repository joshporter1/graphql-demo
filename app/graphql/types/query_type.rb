Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # VirusTotal Files
  field :vtfile do
    type Types::VTFileType
    argument :md5, !types.String
    description "An example field added by the generator"
    resolve ->(obj, args, ctx) {
      Uirusu::VTFile.query_report(VTAPI, args['md5'], allinfo: 1)
      # Uirusu::VTResult.new(args['md5'], Uirusu::VTFile.query_report(VTAPI, args['md5'])).results
    }
  end
end
