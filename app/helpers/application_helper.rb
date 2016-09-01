module ApplicationHelper

   def format_date(time)
     Date.parse(time).strftime("%b %d, %Y")
   end
end
