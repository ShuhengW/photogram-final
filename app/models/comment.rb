# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer
#  photo_id   :integer
#
class Comment < ApplicationRecord
  belongs_to(:author, :required => false, :class_name => "User", :foreign_key => "author_id" ,primary_key: "id")

end
