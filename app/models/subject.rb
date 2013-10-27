class Subject < ActiveRecord::Base
  
  attr_accessible :active, :description, :parent_id, :position, :title
  
  has_ancestry :orphan_strategy => :rootify
  
  validates_presence_of :title, :active
  
  validates_uniqueness_of :title
  
  has_many :subjects, :as => :child_subjects, :foreign_key => 'parent'
  
  has_and_belongs_to_many :roles, :join_table => :roles_subjects
  
  has_many :posts
  
 
  after_create :set_default_data
  
  def set_default_data
    self.position = self.id
    self.parent = self.parent.nil? ? nil : self.parent
    self.save
  end
  
  def child_subjects
    Subject.find(:all, :conditions => ['parent = ?', self.id])
  end
  
  
  def self.recent(limit)
    Subject.where('active is true').order('created_at DESC').limit(limit)
  end
  
end
