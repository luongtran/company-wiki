class Role < ActiveRecord::Base
  attr_accessible :resource_type, :name, :permision_ids, :subject_ids
  
  has_and_belongs_to_many :users, :join_table => :users_roles
  
  has_and_belongs_to_many :permisions, :join_table => :roles_permisions
  belongs_to :resource, :polymorphic => true
  
  has_and_belongs_to_many :subjects, :join_table => :roles_subjects
  
  scopify
end
