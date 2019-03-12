require File.join(File.dirname(__FILE__), "..", 'lib', 'active_mdb')
require 'test/unit'
require File.join(File.dirname(__FILE__), 'test_helper')

class TableTest < Test::Unit::TestCase

  def setup
    create_mdb
    @employee_class = create_model 'employee'
  end

  def test_columns
    columns = @employee_class.columns
    assert_kind_of Array, columns
    assert_kind_of Column, columns.first
    assert_equal 7, columns.size
  end

  def test_create_record_struct
    assert_kind_of Class, @employee_class
    members = @employee_class.column_names
    assert_equal 7, members.size
    assert members.include?('Emp_Id')
  end

  def test_find_first
    y = @employee_class.find_first(:first_name => 'Yolanda')
    assert_kind_of @employee_class, y
    assert_equal 'Yolanda', y.first_name
  end

  def test_find_all
    a_names = @employee_class.find_all(:last_name => 'A')
    assert_kind_of Array, a_names
    assert_kind_of @employee_class, a_names.first
    assert_equal 2, a_names.size
    room_6042 = @employee_class.find_all(:Room => 6042)
    assert_kind_of Array, room_6042
    assert_kind_of @employee_class, room_6042.first
    assert_equal 1, room_6042.size
  end
end
