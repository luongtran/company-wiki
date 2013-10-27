class HomeController < ApplicationFrontEndController
  
  def index
    logger = Logger.new('log/activities.log')
    logger.info('----------Log for activites--------------')
    
    logger.info(@activities.count)
    @activities
  end
  
  def no_permission
    
  end
  
end
