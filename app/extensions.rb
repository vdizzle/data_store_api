module Extensions
  Dir['app/extensions/*.rb'].each do |file|
    autoload File.basename(file, '.rb').camelize, file
  end
end

