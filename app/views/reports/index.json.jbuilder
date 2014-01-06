json.array!(@reports) do |report|
  json.extract! report, :title
  json.url report_url(report, format: :json)
end
