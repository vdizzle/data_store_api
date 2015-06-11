json.array!(@uploads) do |upload|
  json.partial!('uploads/upload', upload: upload)
end
