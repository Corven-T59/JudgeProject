module ContestsHelper
	def subscribe_link
		if @contest.users.exists? current_user			
			link_to 'Unsubscribe', unsubscribe_contest_path, method: :post
		else
			link_to 'Subscribe', subscribe_contest_path, method: :post
		end
	end
	def submit_link
		if @contest.users.exists? current_user
			link_to 'Submit', submit_contest_path, method: :get
		end		
	end
end
