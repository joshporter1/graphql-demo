Types::VTFileType = GraphQL::ObjectType.define do
  name "VTFile"

  field :md5, types.String, hash_key: 'md5'
  field :sha1, types.String, hash_key: 'sha1'
  field :sha256, types.String, hash_key: 'sha256'
  field :first_seen, types.String, hash_key: 'first_seen'
  field :last_seen, types.String, hash_key: 'last_seen'
  field :size, types.Int, hash_key: 'size'
  field :community_reputation, types.String, hash_key: 'community_reputation'
  field :malicious_votes, types.String, hash_key: 'malicious_votes'
  field :submission_names, types[types.String], hash_key: 'submission_names'
  field :itw_urls, types[types.String], hash_key: 'ITW_urls'

  field :raw, types.String do
    resolve ->(obj, args, ctx) {
      obj
    }
  end
end
