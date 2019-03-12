require 'test/unit'
TEST_DB  = File.join(File.dirname(__FILE__), 'mdb_files', 'sample.mdb')
NOT_A_DB = File.join(File.dirname(__FILE__), 'mdb_files', 'not_an_mdb.txt')

class Test::Unit::TestCase

  protected

  def create_mdb(options = {})
    excluded = options[:exclude]
    included = options[:include]
    assert_nothing_raised {@db = MDB.new(TEST_DB, :exclude => excluded, :include => included)}
    assert_not_nil @db
  end

  def create_model(name, table_name = nil)
    @models       ||= {}
    @models[name] ||= begin
      klass_name = name.classify
      table_name ||= klass_name
      eval("class ::#{klass_name} < ActiveMDB::Base
        set_mdb_file '#{TEST_DB}'
        set_table_name '#{table_name}'
      end
      ")
      klass_name.constantize
    end
  end
end
