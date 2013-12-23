# Committed Changes [![Build Status](https://secure.travis-ci.org/wijet/committed_changes.png)](http://travis-ci.org/wijet/committed_changes)

A Rails plugin that maintains visibility to changes after they've been committed to the database.

### What does it do?

Rails clears the `changes` hash for ActiveRecord instances before the `after_commit` callback is fired. This gem adds it back via `committed_changes` and `#{attribute}_changed_and_committed?` methods.

### Why would you need this?

Sometimes you need to wait until after a record is committed to the database to trigger a callback. For example, if you use [Sidekiq](https://github.com/mperham/sidekiq) for background processing, you have to [wait until after the commit](https://github.com/mperham/sidekiq/issues/322) to queue new jobs or else the record may not exist when Sidekiq attempts to perform the job.

### How do you use it?

```ruby
> vhost = Vhost.first

> vhost.name
=> "Foo"

> vhost.name = "Bar"
=> "Bar"

> vhost.changes
=> {"name"=>["Foo", "Bar"]}

> vhost.save
=> true

> vhost.changes
=> {}

> vhost.committed_changes
=> {"name"=>["Foo", "Bar"], "updated_at"=>[Mon, 23 Dec 2013 19:55:46 UTC +00:00, Mon, 23 Dec 2013 19:57:42 UTC +00:00]}

> vhost.name_changed_and_committed?
=> true

```

### Installation

Add this to your Gemfile and run ```bundle install```

```ruby
gem 'committed_changes'
```

### Usage
These features are included into `ActiveRecord::Base` automatically when the gem loads.

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
