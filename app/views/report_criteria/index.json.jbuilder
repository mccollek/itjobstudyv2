json.array!(@report_criteria) do |report_criterium|
  json.extract! report_criterium, :title
  json.url report_criterium_url(report_criterium, format: :json)
end
