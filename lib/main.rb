require 'xmlsimple'
require 'net/http'
require 'socksify'
require 'open-uri'

config = XmlSimple.xml_in(Net::HTTP.get_response(URI.parse('http://www.xroxy.com/proxyrss.xml')).body, { 'KeyAttr' => 'name' })
x=''
config['channel'][0]['item'].each{|c|
                                    c['proxy'].each{|a| x += a['ip'][0] + ":" + a['port'][0] + "\n"}
                                  }

proxylist = x.split("\n")

puts proxylist

proxylist.each{|a|
  begin
        TCPSocket::socks_server = a.split(":")[0]
        TCPSocket::socks_port = a.split(":")[1]
        puts "trying #{a} as #{a.split(":")[0]} with #{a.split(":")[1]}"
        timeout(20) do
        open('http://timeunderscrutiny.blogspot.com', "Referer" => "http://luxury4play.com")
        puts "Operation with #{a} completed."
      end
  rescue Timeout::Error => e
        puts "timed out, trying next proxy (#{e})"
  rescue SOCKSError => e
        puts "generic Socks error (#{e})"
  rescue Exception => e
        puts "Generic Error (#{e})"
  end
  }