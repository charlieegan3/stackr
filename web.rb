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

  `echo $HYPER_JSON > /tmp/config.json`
  pid = Process.spawn("./bin/hyper --config /tmp/ run --size m3 --rm -e VIDEO_URL=#{@url} -e FPS=1 -e ALIGN=false -e MODE=median -e GOOGLE_CLOUD_KEYFILE_JSON='#{ENV.fetch("GOOGLE_CLOUD_KEYFILE_JSON")}' -e GOOGLE_CLOUD_PROJECT='#{ENV.fetch("GOOGLE_CLOUD_PROJECT")}' -e GOOGLE_CLOUD_BUCKET='#{ENV.fetch("GOOGLE_CLOUD_BUCKET")}' charlieegan3/stackr:#{ENV.fetch("IMAGE_TAG")}")
  Process.detach(pid)

  erb :result
end
