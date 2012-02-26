class Vhost < ActiveRecord::Base
  include CommittedChanges
  validates_presence_of :domains
  after_commit :reconfigure_server, :if => :domains_changed_and_committed?

  def reconfigure_server
    # Here background job can be launched
    @reconfigured = true
  end

  def reconfigured?
    !!@reconfigured
  end
end
