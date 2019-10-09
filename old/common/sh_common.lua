function tnextIndex (table)
    local index = 1

	while ( true ) do
		if ( not table[ index ] ) then
			return index
		else
			index = index + 1
		end
	end
end

function tfind(table, s, id)
    for i, c in ipairs(table) do
        if(id) then 
            if(c.id == id) then 
                return i
            end
        elseif(c == s) then 
            return i
        end
	end
	return false
end

function contains(array, value)
    for i=1, #array do
        if(array[i] == value) then
            return value
        end
    end
    return false
end