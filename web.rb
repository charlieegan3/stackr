require 'sinatra'
require "gcloud"

set :bind, '0.0.0.0'

get '/' do
  erb :upload
end

post "/" do
  gcloud = Gcloud.new
  storage = gcloud.storage

  bucket = storage.bucket ENV.fetch("GOOGLE_CLOUD_BUCKET")

  bucket.create_file params['myfile'][:tempfile], params['myfile'][:filename]

  return "The file was successfully uploaded!"
end
