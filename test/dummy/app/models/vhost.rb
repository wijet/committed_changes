class Vhost < ActiveRecord::Base
  include CommittedChanges
  
  validates_presence_of :domains
end
