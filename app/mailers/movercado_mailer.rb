class MovercadoMailer < ActionMailer::Base
  default from: "alert_movercado@example.com"

  def alert_email(user_email,content)
  	@suspicious_content = content
  	mail(:to => user_email, :subject => "Final movercado-analysis submission")
  end
end
