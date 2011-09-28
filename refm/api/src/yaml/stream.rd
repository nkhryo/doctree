ʣ���� YAML �ɥ�����Ȥ���٤˰�������Υ��֥饤�֥��Ǥ���

#@since 1.9.2
= class Syck::Stream < Object
#@else
= class YAML::Stream < Object
#@end

YAML �ɥ�����Ȥ�ʣ���ݻ����뤳�Ȥ��Ǥ��륹�ȥ꡼�९�饹�Ǥ���

=== ����

Rubyist Magazine: [[url:http://jp.rubyist.net/magazine/]]

 * �ץ�����ޡ��Τ���� YAML ���� (�����): [[url:http://jp.rubyist.net/magazine/?0010-YAML]]

== class methods

#@since 1.9.2
--- new(opts = {}) -> Syck::Stream
#@else
--- new(opts = {}) -> YAML::Stream
#@end

���ȥ꡼����֤��ޤ������ȥ꡼���YAML�ɥ�����Ȥ�ʣ���ݻ����뤳�Ȥ��Ǥ��ޤ���

@param opts ���ץ�������ꤷ�ޤ��������ǽ�ʥ��ץ�����
#@since 1.9.2
            [[m:Syck::DEFAULTS]] �򻲾Ȥ��Ƥ���������
#@else
            [[m:YAML::DEFAULTS]] �򻲾Ȥ��Ƥ���������
#@end

#@since 1.9.2
@see [[m:Syck::Stream#options]], [[m:Syck::Stream#options=]]
#@else
@see [[m:YAML::Stream#options]], [[m:YAML::Stream#options=]]
#@end

== instance methods

--- [](i) -> object

i���ܤΥɥ�����Ȥ򻲾Ȥ��ޤ���

@param i ���Ȥ������ɥ�����Ȥ��ֹ����ꤷ�ޤ���

  require 'yaml'
  
  class Dog
    attr_accessor :name
    def initialize(name) 
      @name = name
    end
  end
  
  ys = YAML::Stream.new
  begin
    ys[0] = Dog.new("kuro")
  rescue
    p $!
    #=> #<NoMethodError: undefined method `[]=' for #<YAML::Stream:0x2b07d48 @documents=[], @options={}>>
  end
  
  ys.add Dog.new("pochi") 
  p ys[0]
  #=> #<Dog:0x2b07b04 @name="pochi">

--- add(doc) -> ()

���֥������Ȥ�ɥ�����Ȥ��ɲä��ޤ���

@param doc Ŭ�ڤʥ��֥������Ȥ���ꤷ�ޤ���

  require 'yaml'
  
  class Dog
    attr_accessor :name
    def initialize(name) 
      @name = name
    end
  end
  
  str1=<<EOT
  --- !ruby/Dog
  name: pochi
  EOT
  
  ys = YAML.load_stream(str1)
  p ys.documents
  #=> [#<YAML::DomainType:0x2b07af0 @value={"name"=>"pochi"}, @type_id="Dog", @domain="ruby.yaml.org,2002">]
  ys.add(Dog.new("tama"))
  p ys.documents
  #=> [#<YAML::DomainType:0x2b07af0 @value={"name"=>"pochi"}, @type_id="Dog", @domain="ruby.yaml.org,2002">, #<Dog:0x2b079b0 @name="tama">]

--- edit(doc_num, doc) -> ()

doc_num���ܤΥɥ�����Ȥ�doc���ѹ����ޤ���
�⤷��doc_num�����ߤΥɥ�����ȿ�����礭�����ϴ֤ˤ�nil����������ޤ���

@param doc_num �ѹ������ɥ�����Ȥ��ֹ� 
@param doc Ŭ�ڤʥ��֥�������

  require 'yaml'
  
  class Dog
    attr_accessor :name
    def initialize(name) 
      @name = name
    end
  end
  
  ys = YAML::Stream.new
  ys.add(Dog.new("tama"))
  ys.edit(1, Dog.new("pochi"))
  ys.edit(5, Dog.new("jack"))
  p ys.documents
  #=> [#<Dog:0x2b07c44 @name="tama">, #<Dog:0x2b07c1c @name="pochi">, nil, nil, nil, #<Dog:0x2b07bf4 @name="jack">]

--- emit(io = nil) -> IO | String

���ȥ꡼��˴ޤޤ��ƥɥ�����Ȥ���� io �� YAML �����ǽ񤭹��ߤޤ���
io �� nil �ξ���ʸ������֤��ޤ���

@param io �񤭹������ IO ���֥�������

  require 'yaml'
  
  class Dog
    attr_accessor :name
    def initialize(name) 
      @name = name
    end
  end
  
  ys = YAML::Stream.new
  ys.add(Dog.new("pochi"))
  ys.edit(1, { :age => 17, :color => "white"})
  ys.edit(2, [ "Chiba", "Saitama"])
  ys.emit.split(/\n/).each {|l|
    puts l
  }
  
  #���
  --- !ruby/object:Dog
  name: pochi
  ---
  :age: 17
  :color: white
  ---
  - Chiba
  - Saitama

--- documents -> Array

���ȤΥɥ�����Ȥ�������֤��ޤ���

  require 'yaml'
  
  str1=<<EOT
  --- !ruby/Dog
  name: pochi
  --- 
  :age: 17
  :color: white
  EOT
  
  ys = YAML.load_stream(str1)
  p ys.documents.pop
  #=> {:age=>17, :color=>"white"}
  p ys.documents.pop
  #=> #<YAML::DomainType:0x2b07e24 @type_id="Dog", @domain="ruby.yaml.org,2002", @value={"name"=>"pochi"}>
  p ys.documents.pop
  #=> nil

--- documents=(val)

���ߤΥɥ�����Ȥ���������ꤷ�ޤ���

@param val YAML ���Ѵ��Ǥ���Ǥ�դΥ��֥������Ȥ�����ǻ��ꤷ�ޤ���

--- options -> {Symbol => object}

���ץ����ΰ������֤��ޤ���

--- options=(val)

���ץ����ΰ��������ꤷ�ޤ���

@param val ����� [[c:Hash]] ���֥������Ȥǻ��ꤷ�ޤ��������ǽ�ʥ��ץ���
#@since 1.9.2
           ��� [[m:Syck::DEFAULTS]] �򻲾Ȥ��Ƥ���������
#@else
           ��� [[m:YAML::DEFAULTS]] �򻲾Ȥ��Ƥ���������
#@end