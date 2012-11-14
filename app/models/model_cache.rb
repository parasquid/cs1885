# see http://danlynn.org/home/2012/2/8/ruby-caching-technique.html
module ModelCache
  
  def cache(&proc)
    caller[0] =~ /(.*?):(\d+)(?::in\s*`(.*?)')?/
    method_name = $3
    local_variable_values = eval('local_variables.collect{|var| eval(var)}', proc.binding)
    locals = eval('local_variables.collect{|var| var + " = " + eval(var).inspect}.join(", ")', proc.binding)
    puts "cache called from: #{self}.#{method_name}(#{locals})"
    cache = Thread.current[:cache] ||= Hash.new{|hash, key| hash[key] = Hash.new{|hash, key| hash[key] = {} }}
    cache[self][method_name][local_variable_values] ||= yield
  end
  
end