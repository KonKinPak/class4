class User < ApplicationRecord
	validates :email,presence:true ,uniqueness:true 
	validates :name, length: {minimum:2}
	validates :pass, presence:true
	has_many :posts
end
