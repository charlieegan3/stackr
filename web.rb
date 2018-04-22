require "sinatra"
require "gcloud"
require "digest"

set :bind, "0.0.0.0"

get "/" do
  erb :upload
end

post "/" do
  return "not video" unless params["myfile"][:filename].include?("mp4")
  bucket = ENV.fetch("GOOGLE_CLOUD_BUCKET")

  name = "video_#{Digest::MD5.hexdigest(params["myfile"][:filename] + Time.now.to_s)}.mp4"

  Gcloud.new.storage.bucket(bucket).create_file(params["myfile"][:tempfile], name)

  @url = "https://storage.googleapis.com/#{bucket}/#{name}"
  erb :result
end
