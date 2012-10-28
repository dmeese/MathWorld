class MathContentController < ApplicationController
  
#This layout command checks a variable to determine if the teacher or the student layout should be presented.  Ideally, the variable will be gobal.
#I picked @isteacher as n instance variable because it works well enough not to crash.  We need to get it workign correctly though.
  layout :teacherOrStudent
  @isTeacher = false  #This seems to be persistent for some reasom.  Need to figure out how to set this variable based on events.
  					  #Even when I switch it, it doesnt switch to the alternate

  def public
  end

  def authUser
  end

 private
 	def teacherOrStudent
 		if @isTeacher = true
 			"contentTeacher"
 		else
 			"contentStudent"
 		end
 	end	
end
