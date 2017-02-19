class User < ActiveRecord::Base

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :slack_id, presence: true, uniqueness: { case_sensitive: false }

end
