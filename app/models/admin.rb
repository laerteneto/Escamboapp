class Admin < ActiveRecord::Base
	enum role: {:full_access => 0, :restricted_access => 1}

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  #scope :with_full_access, -> { where(role: 0) } - The same result using scope
  def self.with_full_access
    where(role: 0)
  end


end
