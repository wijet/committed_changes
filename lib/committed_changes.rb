module CommittedChanges
  extend ActiveSupport::Concern
  
  included do
    after_save :__store_changes_before_commit
    after_commit :__changes_committed
  end
  
  # Returs hash of committed changes
  def committed_changes
    @__committed_changes || {}
  end

  private
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
