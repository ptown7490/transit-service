module ResponseParsing
  def jsonParseBody(response)
    JSON.parse(response.body)
  end
end
