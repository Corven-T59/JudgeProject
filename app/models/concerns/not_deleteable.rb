module NotDeleteable
  extend ActiveSupport::Concern

  def destroy
    unless self.respond_to? :disabled
      raise MissingMigrationException
    end

    self.update_attribute :disabled, true
  end

  def delete
    self.destroy
  end

  def self.included(base)
    base.class_eval do
      scope "valid_#{base.model_name.collection}".to_sym, -> { where(disabled: false) }
    end
  end
end

class MissingMigrationException < Exception
  def message
    "Model is lacking the disabled boolean field for NotDeleteable to work"
  end
end