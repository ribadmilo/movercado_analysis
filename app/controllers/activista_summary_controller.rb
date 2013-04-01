class ActivistaSummaryController < ApplicationController

	def index
		@activistas = Interaction.joins(:user => :roles).where("roles.name = 'activista' AND  date_trunc('week', interactions.created_at) = date_trunc('week',TIMESTAMP '2013-04-01 00:00:00')").group("interactions.user_id").count("interactions.user_id", :order => "count_interactions_user_id DESC LIMIT 10")
	
		@activistas.each {|k, v|  
			
			total = @activistas[k]
			first = User.find(k).interactions.order("created_at ASC").first.created_at
			last = User.find(k).interactions.order("created_at ASC").last.created_at
			 @activistas[k] = [total, first, last]
			}
	end

end