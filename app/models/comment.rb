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

require 'stripify' 

class Comment < ActiveRecord::Base
  attr_accessible :body, :commenter, :document_id

  #belongs_to is an ActiveRecord method which establishes a 
  #foreign key relationship, with this record as the child
  belongs_to :document, :foreign_key => :id


  #set up remove_evil as an event callback, to be called before
  #the record is committed to the data repository.
  before_save :remove_evil

  def remove_evil()
    self.body = Stripify::stripify(self.body)
  end

end
