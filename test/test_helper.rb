require 'nanotest'
require 'nanotest/contexts'
require 'nanotest/stats'
require 'nanotest/spec'
require 'nanotest/focus'

$:.unshift( File.expand_path(File.dirname(__FILE__)) )
$:.unshift( File.join(File.expand_path(File.dirname(__FILE__)), "..", "lib"))

require 'dm-zone-types'
require 'dm-migrations'

include Nanotest
include Nanotest::Contexts

DataMapper.setup(:default, 'sqlite::memory:')

class SpecModel
  include DataMapper::Resource
  property :id, Serial
  property :zoned_time, ZonedTime
end
