json.array!(@bls_column_mappers) do |bls_column_mapper|
  json.extract! bls_column_mapper, 
  json.url bls_column_mapper_url(bls_column_mapper, format: :json)
end
