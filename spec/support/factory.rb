require 'digest/md5'

def generate_token
  Digest::MD5.new.update(rand(10).to_s).to_s
end

def generate_id
  Time.now.to_i
end

ACCESS_ID = generate_token
ACCESS_PASS = generate_token