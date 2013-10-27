class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :department, :birthday, 
                  :role_ids, :avatar, :last_sign_in_at, :address, :phone_number, :about_me, :get_notification_to_email
  
  has_attached_file :avatar,
                  :styles => { :thumb => "40x40>", :medium => "180x200>" }
                  
  #validates_attachment_presence :avatar
  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/jpg', 'image/gif']
  # attr_accessible :title, :body
  
  has_and_belongs_to_many :roles, :join_table => :users_roles
  
  has_many :posts
  has_many :comments
  
  has_many :user_activities_logs
  
  #has_many :subjects, through: :roles
  
  def self.recent(limit)
    User.find(:all, :order => "created_at DESC", :limit => limit)
  end
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
end
