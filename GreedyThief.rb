

its=[
 {weight:2,price:6},
 {weight:2,price:3},
 {weight:6,price:5},
 {weight:5,price:4},
 {weight:4,price:6}
 ]


def add_weights (items)
	total_weight = 0
	items.each{|item|
		total_weight += item[:weight]
	}

	return total
end

def sort_items(items)
	sorted_items = items.sort_by{|item| [item[:weight], -item[:price]]}
	return sorted_items
end

def items_val(items, weights)
	total_val = 0
	
	weights.each{|weight|
		
		val_index = items.find_index{|item| item[:weight] == weight}

		unless val_index.nil?

			total_val = total_val + items[val_index][:price].to_int	

			#items.delete_at(items.index(items[val_index]) || items.length)
		end
	}
	return total_val
end

def find_possible_combos (items, n)
	weights = []
	max = []
	max_val = 0
	items.each{|item|
		weights << item[:weight].to_i
	}
	for i in 0..(weights.length)
		weights.combination(i).each{|possibility|
			if ((possibility.inject(0){|sum,x| sum + x }) <= n) 

				if (items_val(items, possibility) > max_val)
					max_val = items_val(items, possibility)
					max = possibility
				end 
			end
		}
		
	end
	
	return max
end

def items_from_weights (items, weights)

	final_list = []

		weights.each{|weight|
		
		val_index = items.find_index{|item| item[:weight] == weight}

		unless val_index.nil?
			final_list << items[val_index]
			items.delete_at(items.index(items[val_index]) || items.length)
		end
	}
	return final_list

end

def greedyThief (items, n)
	
	sorted_items = sort_items(items)


	weight_list = find_possible_combos(sorted_items, n)

	answer = items_from_weights(sort_items(items), weight_list)

	return answer

end



puts greedyThief(its, 10)



