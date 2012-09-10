require 'xmlsimple'

config = XmlSimple.xml_in('~/Downloads/proxyrss.xml', { 'KeyAttr' => 'name' })

config['channel'][0]['item'][0]['proxy'].each{|a| puts a['ip'][0] + ":" + a['port'][0]}