# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  comments_count         :integer
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  likes_count            :integer
#  private                :boolean
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many(:accepted_sent_follow_requests, -> { where :status => "accepted" }, :class_name => "FollowRequest", :foreign_key => "sender_id", primary_key: "id")
  has_many(:accepted_received_follow_requests, -> { where :status => "accepted" }, :class_name => "FollowRequest", :foreign_key => "recipient_id", primary_key: "id")
  has_many(:pending_sent_follow_requests, -> { where :status => "pending" }, :class_name => "FollowRequest", :foreign_key => "sender_id", primary_key: "id")
  has_many(:pending_received_follow_requests, -> { where :status => "pending" }, :class_name => "FollowRequest", :foreign_key => "recipient_id", primary_key: "id")
  has_many(:followers, :through => :accepted_received_follow_requests, :source => :sender)
  has_many(:leaders, :through => :accepted_sent_follow_requests, :source => :recipient)
  has_many(:pending_followers, :through => :pending_received_follow_requests, :source => :sender)
  has_many(:pending_leaders, :through => :pending_sent_follow_requests, :source => :recipient)
end
