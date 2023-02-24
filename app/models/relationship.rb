class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "Customer"
  belongs_to :followed, class_name: "Customer"
  # followerテーブルとfollowedテーブルを探しに行ってしまうので、class_name: "Customer"でcustomerテーブルからデータをとってくる
end
