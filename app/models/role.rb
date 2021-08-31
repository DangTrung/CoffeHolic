class Role < ApplicationRecord
	before_save { self.name = name.downcase! }

	 validates :name, presence: true, uniqueness: true
	 has_and_belongs_to_many :permissions
	 has_many :users
end
