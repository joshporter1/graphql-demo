GraphqlDemoSchema = GraphQL::Schema.define do
  mutation(Types::MutationType)
  query(Types::QueryType)
  vthash(Types::VTHashType)
end
