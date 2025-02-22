# == Schema Information
#
# Table name: follow_requests
#
#  id           :bigint           not null, primary key
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#
class FollowRequest < ApplicationRecord
  belongs_to(:sender, :required => false, :class_name => "User", :foreign_key => "sender_id" ,primary_key: "id")
  belongs_to(:recipient, :required => false, :class_name => "User", :foreign_key => "recipient_id" ,primary_key: "id")

  has_many(:likes, :class_name => "Like", :foreign_key => "photo_id", :dependent => :destroy)
end
