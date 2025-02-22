# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fan_id     :integer
#  photo_id   :integer
#
class Like < ApplicationRecord
  belongs_to(:fan, :required => false, :class_name => "User", :foreign_key => "fan_id" ,primary_key: "id")

  # Like#photo: returns a row from the photo table associated to this like by the photo_id column
  belongs_to(:photo, :required => false, :class_name => "Photo", :foreign_key => "photo_id" ,primary_key: "id")
end
