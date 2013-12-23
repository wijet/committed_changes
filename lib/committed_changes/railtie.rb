module CommittedChanges
  class Railtie < Rails::Railtie
    initializer 'committed_changes.initialize' do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :include, Dirty
      end
    end
  end
end
