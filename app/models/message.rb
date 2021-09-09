class Message < ApplicationRecord
	validates :content, presence: true
	belongs_to :sender, class_name: "User", foreign_key: "user_id"
end
