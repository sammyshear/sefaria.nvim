local url = {}

url.encode = function(str)
    str = string.gsub(str, "([^%w%.%- ])", function(c)
        return string.format("%%%02X", string.byte(c))
    end)
    str = string.gsub(str, "%s+", "%%20")
    return str
end

return url
