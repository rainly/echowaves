# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  
  filter_parameter_logging "password"
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => '9a126b23de542e647165efc443bbc7eb'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  
end

ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
        :pretty => "%b %d, %Y",
        :pretty_long => "%b %d, %Y %I:%M%p",
        :date_time12 => "%m/%d/%Y %I:%M%p",
        :date_time24 => "%m/%d/%Y %H:%M"
      )