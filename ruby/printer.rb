def pr_str(mal_data)
  if mal_data.is_a?(Array) then
    "(" + mal_data.map {|data| pr_str(data)}.join(" ") + ")"
  elsif mal_data.is_a?(Integer) then
    mal_data.to_s
  elsif mal_data.is_a?(String) then
    mal_data
  end
end

