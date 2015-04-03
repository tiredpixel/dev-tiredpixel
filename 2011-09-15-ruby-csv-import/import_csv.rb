# Usage:
#   import_csv("path_to_file", 'Model name', 'unique property, such as name')

require 'csv'

def import_csv(file, model, idkey)
  puts
  puts "=========="
  puts "import_csv"
  puts "=========="
  
  puts "model: #{model}"
  puts "file:  #{file}"
  puts "idkey: #{idkey}"
  
  count_create = 0
  count_update = 0
  count_rows = 0
  
  t0 = Time.now
  
  f = CSV.open(file, 'r')
  header = f.shift
  
  Module.const_get(model).transaction do
    for row in f
      count_rows += 1
      
      params = {}
      
      header.each_with_index do |key, i|
        split_key = key.split(" ")
        
        if split_key.length == 1
          params[key] = row[i]
        else
          a_record = Module.const_get(split_key[0].camelcase).find(
            :first,
            :conditions => {
              split_key[1] => row[i]
            }
          )
          
          params[split_key[0]] = a_record
        end
      end
      
      if block_given?
        status = yield(params)
      else
        record = Module.const_get(model).find(
          :first,
          :conditions => {
            idkey => params[idkey]
          }
        )
        
        if record
          status = record.update_attributes(params)
          
          count_update += 1
        else
          record = Module.const_get(model).new(params)
          
          status = record.save
          
          count_create += 1
        end
      end
      
      print status ? "." : "!"
    end
  end
  
  t = Time.now - t0
  
  puts
  
  puts "time: #{t}"
  
  puts "#{model}:"
  puts "  rows:    #{count_rows}"
  puts "  created: #{count_create}"
  puts "  updated: #{count_update}"
  puts "  records: #{Module.const_get(model).count}"
end
