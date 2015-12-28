String.prototype.toCamelCase = (str) ->
    return str
        .replace /\s(.)/g, ($1) ->
            return $1.toUpperCase()
        .replace /\s/g, '' 
        .replace /^(.)/, ($1) -> 
            return $1.toLowerCase()

