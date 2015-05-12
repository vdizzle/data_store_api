module Routes
  Dir['app/routes/*.rb'].each do |file|
    autoload File.basename(file, '.rb').camelize, file
  end
end

module Routes::V1
  Dir['app/routes/v1/*.rb'].each do |file|
    autoload File.basename(file, '.rb').camelize, file
  end
end
