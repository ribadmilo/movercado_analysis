class ActivistaSummaryController < ApplicationController

	def index
		if request.xhr? && params[:d_week]
		 	@current_week_day_start = DateTime.parse(params[:d_week]).beginning_of_week.to_formatted_s(:db)
		 	@current_week =  "#{DateTime.parse(params[:d_week]).beginning_of_week.cweek} - #{DateTime.parse(params[:d_week]).beginning_of_week.to_formatted_s(:long)} to #{DateTime.parse(params[:d_week]).beginning_of_week.advance(:days => 6).to_formatted_s(:long)}"
		else
			@current_week_day_start = DateTime.now.beginning_of_week.to_formatted_s(:db)
			@current_week = "#{DateTime.now.beginning_of_week.cweek} - #{DateTime.now.beginning_of_week.to_formatted_s(:long)} to #{DateTime.now.beginning_of_week.advance(:days => 6).to_formatted_s(:long)}"
		end

		@activistas = Interaction.joins(:user => :roles).where("roles.name = 'activista' AND  date_trunc('week', interactions.created_at) = date_trunc('week',TIMESTAMP '#{@current_week_day_start}')").group("interactions.user_id").count("interactions.user_id", :order => "count_interactions_user_id DESC LIMIT 10")
		@activistas.each {|k, v|  
			
			total = @activistas[k]
			first = User.find(k).interactions.order("created_at ASC").first.created_at.to_s
			last = User.find(k).interactions.order("created_at ASC").last.created_at.to_s
			 @activistas[k] = [total, first, last]
		}

		@activistas = Hash[@activistas.sort] #puts result sorted by user_id

		if request.xhr?
			respond_to do |format|
		      format.json { render :json => { :current_week =>@current_week, :activistas => @activistas}}
		    end
		end
	end

end