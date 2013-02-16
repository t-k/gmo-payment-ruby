require 'digest/md5'

def generate_token
  Digest::MD5.new.update(rand(10).to_s).to_s
end

ACCESS_ID = generate_token
ACCESS_PASS = generate_token