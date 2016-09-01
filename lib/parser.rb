module Parser
  def parse(response)
    JSON.parse(response.body, symbolize_name: true, object_class: OpenStruct)
  end
end
