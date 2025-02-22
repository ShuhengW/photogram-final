# == Schema Information
#
# Table name: photos
#
#  id             :bigint           not null, primary key
#  caption        :text
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Photo < ApplicationRecord
  mount_uploader :image, ImageUploader

  has_many(:likes, :class_name => "Like", :foreign_key => "photo_id", :dependent => :destroy)
  belongs_to(:poster, :required => false, :class_name => "User", :foreign_key => "owner_id" ,primary_key: "id")
  has_many(:comments, :class_name => "Comment", :foreign_key => "photo_id", :dependent => :destroy)

  # Photo#likes: returns rows from the likes table associated to this photo by the photo_id column
  has_many(:likes, :class_name => "Like", :foreign_key => "photo_id", :dependent => :destroy)

  ## Indirect associations

  # Photo#fans: returns rows from the users table associated to this photo through its likes
  has_many(:fans, :through => :likes, :source => :fan)
  # Photo#commenters: returns rows from the users table associated to this photo through its comments
  has_many(:commenters, :through => :comments, :source => :author)
end
