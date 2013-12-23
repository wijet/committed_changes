module CommittedChanges
  module Dirty
    extend ActiveSupport::Concern

    included do
      attribute_method_suffix "_changed_and_committed?"
      after_save :__store_changes_before_commit
    end

    # Returs hash of committed changes
    def committed_changes
      @__committed_changes || {}
    end

    # Invoked by rails after record has been committed
    def committed!
      __changes_committed
      super
    end

  private
    # Returns true if attribute was changed and committed
    #
    # Ideas for a better method name are more than welcome
    def attribute_changed_and_committed?(attr)
      committed_changes.keys.include?(attr)
    end

    # Stores changes which will be committed in transaction
    def __store_changes_before_commit
      @__changes_to_commit = changes.dup
    end

    # After the transaction is committed, assigns stored changes
    # to committed changes
    def __changes_committed
      @__committed_changes = @__changes_to_commit
    end

  end
end