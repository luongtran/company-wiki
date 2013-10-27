class Permision < ActiveRecord::Base
  attr_accessible :active, :title
  has_and_belongs_to_many :roles
end
