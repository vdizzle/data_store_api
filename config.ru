require './app'

map '/' do
  run DataStoreApi::App
end
