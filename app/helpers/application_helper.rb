module ApplicationHelper
  def full_title(title)
    if  title.empty?
    "||| Twitter by Yeahgor |||"
    else
    "#{title} | Twitter by Yeahgor"
  end
  end
  
end
