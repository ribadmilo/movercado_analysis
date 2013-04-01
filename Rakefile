#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

MovercadoAnalysis::Application.load_tasks


namespace :trokaAki  do

	task :create1000  => :environment do
		t = TrocaAkiValidation.where(name: "Troca Aki Campaign", code: "TTT").first_or_create
		#Create a vendor user
		u = User.create!
  		u.roles.create(app_id: t.id, name: "vendor")
		1001.times do
		   Interaction.create(:name => 'Troca Aki interaction', :user_id =>u.id, :app_id =>t.id)
  		end
	
	end
end
