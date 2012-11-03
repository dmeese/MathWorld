class MathContentController < ApplicationController
  
#This layout command checks a variable to determine if the teacher or the student layout should be presented.  Ideally, the variable will be gobal.
#I picked @isteacher as n instance variable because it works well enough not to crash.  We need to get it workign correctly though.

  def public
  end

  def teacher
  end

  def student
  end
 end
