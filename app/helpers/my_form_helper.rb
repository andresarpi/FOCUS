module MyFormHelper
  def form_alert(error, key)
    
    if areThereErrors(error, key)
      errorMessage = key.to_s.humanize
      
      error[key].each do |msg|
       errorMessage += " #{msg} and"
      end
      
      errorMessage = errorMessage[0..-4]
      
      data = "<span class='help-block'>#{errorMessage} </span>"
      data.html_safe
    else
      return ""
    end

  end
  
  
  def areThereErrors(error, key)
    if error[key].count == 0
      false
    else
      true
    end
  end 
  
end