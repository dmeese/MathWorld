# Function to strip all special characters from the user_input. 
module Stripify

def self.stripify(input_string)
	output = input_string.tr(%q{;`"'}, '') 
	output.gsub('--','- - ') # render -- safe as well
	return output 
end

# Un comment to test
#
#my_string="This is an 'evil' string with \"lots\" of `nasty` things; in it..."
#print my_string
#print
#print stripify(my_string)
#
# 
end
