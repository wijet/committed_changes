require 'test_helper'

class CommittedChangesTest < ActiveSupport::TestCase
  # We want after_commit callback to work properly
  self.use_transactional_fixtures = false

  fixtures :vhosts
  
  test "storing committed changes in committed_changes attribute" do
    foo = Vhost.find_by_name("Foo")
    foo.domains = "bar.example.com"
    foo.save
    assert_equal %w[foo.example.com bar.example.com], foo.committed_changes[:domains]
  end
  
  test "committed_changes returns empty hash when save fails" do
    foo = Vhost.find_by_name("Foo")
    foo.domains = nil
    foo.save
    assert_equal({}, foo.committed_changes)
  end
end
