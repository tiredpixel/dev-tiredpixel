# e.g.
# 
#   pbpaste | ruby json_formatter.rb | pbcopy

require 'json'

input = $stdin.read


def sort(data)
  if data.is_a?(Array)
    data.sort.map { |e|
      sort(e)
    }
  elsif data.is_a?(Hash)
    Hash[Hash[data.sort].map { |k, v|
      [k, sort(v)]
    }]
  else
    data
  end
end


data = JSON.parse(input)
data = sort(data)
output = JSON.pretty_generate(data)


puts output
