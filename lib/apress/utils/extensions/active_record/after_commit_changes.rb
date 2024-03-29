# frozen_string_literal: true
module Apress::Utils::Extensions::ActiveRecord::AfterCommitChanges
  extend ActiveSupport::Concern

  included do
    before_save :clear_before_commit_changes, if: proc { @clear_before_commit_changes_on_save }
    after_save  :store_before_commit_changes

    after_commit do
      @clear_before_commit_changes_on_save = true
    end

    attribute_method_suffix '_before_commit_changed?', '_before_commit_was'
  end

  def before_commit_changed?
    !before_commit_changed_attributes.empty?
  end

  def before_commit_changed
    before_commit_changed_attributes.keys
  end

  protected

  def before_commit_changed_attributes
    @before_commit_changed_attributes ||= {}
  end

  def clear_before_commit_changes
    @clear_before_commit_changes_on_save = false
    @before_commit_changed_attributes = {}
  end

  def store_before_commit_changes
    before_commit_changed_attributes.merge!(changes)
  end

  # Handle <tt>*_changed?</tt> for +method_missing+.
  def attribute_before_commit_changed?(attr)
    before_commit_changed_attributes.include?(attr)
  end

  # Handle <tt>*_was</tt> for +method_missing+.
  def attribute_before_commit_was(attr)
    attribute_before_commit_changed?(attr) ? before_commit_changed_attributes[attr] : __send__(attr)
  end
end