#ps.rb
require 'sinatra'

base36 = "0123456789abcdefghijklmnopqrstuvwxyz"

module AnyBase
  ENCODER = Hash.new do |h,k|
    h[k] = Hash[ k.chars.map.with_index.to_a.map(&:reverse) ]
  end
  DECODER = Hash.new do |h,k|
    h[k] = Hash[ k.chars.map.with_index.to_a ]
  end
  def self.encode( value, keys )
    ring = ENCODER[keys]
    base = keys.length
    result = []
    until value == 0
      result << ring[ value % base ]
      value /= base
    end
    result.reverse.join
  end
  def self.decode( string, keys )
    ring = DECODER[keys]
    base = keys.length
    string.reverse.chars.with_index.inject(0) do |sum,(char,i)|
      sum + ring[char] * base**i
    end
  end
end

get "/" do
  'hello, bot'
end

get "/hehe/:name" do
   # AnyBase.encode(88878798, base36)
    AnyBase.encode(params[:name], base36)
end

get "/loader/:name" do
    AnyBase.decode(param[:name], base36)
end
