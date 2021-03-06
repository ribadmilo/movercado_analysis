class Interaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :app
  attr_accessible :name, :user_id, :app_id

  after_create :suspicious_activity
  

  def suspicious_activity
  
  total_trokaAki = Interaction.joins(:user =>:roles).where("interactions.user_id = '#{self.user_id}' AND roles.name ='vendor' AND date_trunc('month', interactions.created_at) = date_trunc('month', current_timestamp)").group("interactions.user_id").count
	unless total_trokaAki.size == 0
		if total_trokaAki.first.last > 1000 && total_trokaAki.first.last < 1005 #testing purposes
	 		MovercadoMailer.alert_email('movercado-jobs@psi.org.mz',"User, vendor, #{self.user_id} is having to much activity for this month. Verify it!").deliver
	 	end
	end
  end

end
