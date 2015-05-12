Dir['app/models/*.rb'].each do |file|
  autoload File.basename(file, '.rb').camelize, file
end
