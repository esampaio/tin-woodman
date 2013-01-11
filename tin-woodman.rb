# encoding: utf-8

class Ginfes
  @queue = :file_download

  def self.perform id
    xml = Xml.new id
    begin
      xml.download
    end until xml.valid?
  end
end

class Xml
  attr_reader :xml_path, :xml, :id

  def initialize id
    @id = id
  end

  def download
    @xml_path = %x(./vendor/casperjs/bin/casperjs tin-woodman.coffee #{@id}).chomp
    fix if File.exists? @xml_path and %x(file -b --mime-encoding #{@xml_path}).chomp == 'iso-8859-1'
    read
  end

  def fix
    @xml = %x(iconv -f iso-8859-1 -t utf-8 #{@xml_path})
    File.open(@xml_path, 'w') {|f| f.write(@xml) }
  end

  def read
    @xml = File.read(@xml_path, mode: 'r:utf-8') if File.exists? @xml_path
  end

  def valid?
    /SERVI/ =~ @xml 
  end
end
