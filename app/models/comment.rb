# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  body        :string(255)
#  document_id :integer
#  commenter   :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Comment < ActiveRecord::Base
  attr_accessible :body, :commenter, :document_id

  #belongs_to is an ActiveRecord method which establishes a 
  #foreign key relationship, with this record as the child
  belongs_to :document, :foreign_key => :id
end
