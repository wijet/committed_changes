require 'test_helper'

class CommittedChangesTest < ActiveSupport::TestCase
  # We want after_commit callback to work properly
  self.use_transactional_fixtures = false

  fixtures :vhosts

  test "#committed_changes returns changes hash after commit" do
    foo = Vhost.find_by_name("Foo")
    foo.domains = "bar.example.com"
    foo.save
    assert_equal %w[foo.example.com bar.example.com], foo.committed_changes[:domains]
    assert_nil foo.committed_changes[:name]
  end

  test "#committed_changes returns empty hash when transaction is not comitted" do
    foo = Vhost.find_by_name("Foo")
    # domains must be present
    foo.domains = nil
    foo.save
    assert_equal({}, foo.committed_changes)
  end

  test '#{attribute}_changed_and_committed?' do
    foo = Vhost.find_by_name("Foo")
    foo.name = "bar"
    foo.save
    assert !foo.domains_changed_and_committed?

    foo.domains = "bar.example.com"
    foo.save
    assert foo.domains_changed_and_committed?
  end
end
