# CommittedChanges

Rails plugin which provides hash with changes committed to the database.

### What problem does it solve ?

It's useful when you wan't to trigger a callback depend on changed attributes after data is committed to the database.

Normally you would do that in after_commit callback, the problem is that changes hash is already cleared.

This is where committed_changes hash comes in.

### Installation

Add this to your Gemfile and run ```bundle install```

```ruby
gem 'committed_changes'
```

### Usage
```ruby
class Vhost < ActiveRecord::Base
  include CommittedChanges
  after_commit :reconfigure_server, :if => :domains_changed_and_committed?

  def reconfigure_server
    # launch backgroud job
  end
end

foo = Vhost.first
foo.domains = "new.example.com"
foo.save

foo.changes #=> {}
foo.committed_changes #=> {"domains" => ["old.example.com", "new.example.com"]}
foo.domains_changed_and_committed? #=> true
```

###
Running tests

```
cd test/dummy
rake db:migrate
rake db:test:prepare
cd ../..
rake test
```

This project rocks and uses MIT-LICENSE.