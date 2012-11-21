# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  owner       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# Authoriation_Level for documents is the same as course #
# The course '0' is 'Private'
# The course '1' is 'Public'
# Then other courses can be added by the Teachers.
#
# A teacher can have more than one course
# A course can have more than one student
# Many students can request to be added to a course

class Course < ActiveRecord::Base
  attr_accessible :name, :owner

  #belongs_to is an ActiveRecord method which establishes a 
  #foreign key relationship, with this record as the child
  belongs_to :user, :foreign_key => :id
  has_many :users
end
