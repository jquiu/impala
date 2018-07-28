module ApplicationHelper
	
	def number_to_currency_br(number)
		number_to_currency(number, :unit => "$ ", :separator => ",", :delimiter => ".")
	end

	
	def sortable(column, title = nil)
		title ||= column.titleize
		css_class = column == sort_column ? "current #{sort_direction}" : nil
		direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
		link_to title, {:sort => column, :direction => direction}, {:class => css_class}
	end
	
	def boolean_translate(parameter)
		if parameter
			return "SI"
		else
			return "NO"
		end
	end

	def statuts(offer_status)
		if offer_status == 1
			return "Desactivar"
		else
			return "Activar"
		end
	end

	def user_count(offer)
		if offer.users.count > 0
			return  offer.users.count
		end
	end

end