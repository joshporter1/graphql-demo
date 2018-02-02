Types::VTDomainType = GraphQL::ObjectType.define do
    name "VTDomain"

    field :raw, types.String do
      resolve ->(obj, args, ctx) {
        obj
      }
    end
  end
