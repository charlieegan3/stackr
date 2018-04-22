require "sinatra"
require "google/cloud/storage"
require "digest"

set :bind, "0.0.0.0"

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  username == ENV.fetch("WEB_USER") and password == ENV.fetch("WEB_PASSWORD")
end

get "/" do
  erb :upload
end

post "/" do
  return "not video" unless params["myfile"][:filename].include?("mp4")
  bucket = ENV.fetch("GOOGLE_CLOUD_BUCKET")

  name = "video_#{Digest::MD5.hexdigest(params["myfile"][:filename] + Time.now.to_s)}.mp4"

  Google::Cloud::Storage.new.bucket(bucket).create_file(params["myfile"][:tempfile], name)
  @url = "https://storage.googleapis.com/#{bucket}/#{name}"

  `echo $HYPER_JSON > /tmp/config.json`
  pid = Process.spawn("./bin/hyper --config /tmp/ run --size m3 --rm -e VIDEO_URL=#{@url} -e FPS=#{params["fps"]} -e ALIGN=#{params["align"]} -e MODE=#{params["mode"]} -e GOOGLE_CLOUD_KEYFILE_JSON='#{ENV.fetch("GOOGLE_CLOUD_KEYFILE_JSON")}' -e GOOGLE_CLOUD_PROJECT='#{ENV.fetch("GOOGLE_CLOUD_PROJECT")}' -e GOOGLE_CLOUD_BUCKET='#{ENV.fetch("GOOGLE_CLOUD_BUCKET")}' charlieegan3/stackr:#{ENV.fetch("IMAGE_TAG")}")
  Process.detach(pid)

  erb :result
end
