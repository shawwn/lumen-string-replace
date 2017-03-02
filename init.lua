function string_replace(str, a, b, count, pos)
  local k = _35(a)
  local n = count or inf
  if count == 0 or n <= 0 or k <= 0 then
    return(str)
  else
    local i = pos or 0
    local j = search(str, a, i)
    local s = clip(str, 0, i)
    while (j or j == 0) and n > 0 do
      n = n - 1
      s = s .. clip(str, i, j) .. b
      i = j + k
      j = search(str, a, i)
    end
    s = s .. clip(str, i)
    return(s)
  end
end
return({["string-replace"] = string_replace})
