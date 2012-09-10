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
        timeout(20) do
        open('http://timeunderscrutiny.blogspot.com')
        puts "Operation with #{a} completed."
      end
  rescue Timeout::Error
        puts "timed out, trying next proxy"
  rescue SOCKSError
        puts "generic Socks error"
  rescue Exception
        puts "Generic Error"
  end
  }