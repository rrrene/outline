class QuickJumpTarget < ActiveRecord::Base
  belongs_to :domain
  belongs_to :resource, :polymorphic => true

  def self.update(resource)
    phrase = resource.quick_jump_phrase
    if resource.quick_jump_target
      resource.quick_jump_target.update_attribute :phrase, phrase
    else
      resource.build_quick_jump_target(:domain => resource.domain, :phrase => phrase).save
    end
  end

  def self.update_all(*models)
    [models].flatten.each do |model|
      model.all.each do |record|
        update(record)
      end
    end
  end

  validates_presence_of :domain
  validates_presence_of :resource
  validates_presence_of :phrase
end
