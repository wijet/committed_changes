# Committed Changes [![Build Status](https://secure.travis-ci.org/wijet/committed_changes.png)](http://travis-ci.org/wijet/committed_changes)
---

A Ruby on Rails plugin which provides hash with changes committed to the database.

### What problem does it solve ?

It's useful when you want to trigger a callback depend on changed attributes after data is committed to the database.

Normally you would do that in ```after_commit``` callback, the problem is that ```changes``` hash is already cleared.

This is where ```committed_changes``` hash comes in.

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
    # launch background job
  end
end

foo = Vhost.first
foo.domains = "new.example.com"
foo.save

foo.changes #=> {}
foo.committed_changes #=> {"domains" => ["old.example.com", "new.example.com"]}
foo.domains_changed_and_committed? #=> true
```

### Contributions

To fetch & test the library for development, do:

    $ git clone https://github.com/wijet/committed_changes
    $ cd committed_changes
    $ bundle

#### Running tests

    # Preparing test database
    $ cd test/dummy && bundle exec rake db:migrate && bundle exec rake db:test:prepare
    $ cd ../..
    # Running tests
    $ bundle exec rake test

If you want to contribute, please:

    * Fork the project.
    * Make your feature addition or bug fix.
    * Add tests for it. This is important so I don't break it in a future version unintentionally.
    * Send me a pull request on Github.

This project rocks and uses MIT-LICENSE.
