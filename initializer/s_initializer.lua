local resources = {"common", "notify", "account", "realism", "stats", "vehicle"}

addEventHandler( "onResourceStart", resourceRoot,
	function( )
		local tick = getTickCount( )

		for _, resourceName in ipairs( resources ) do
			local resource = getResourceFromName( resourceName )
			
			if ( resource ) then
				local load_failed = false
		
				if ( getResourceState( resource ) == "running" ) then
					if ( not restartResource( resource ) ) then
						load_failed = "restartResource failed of resource" ..resourceName
					end
				elseif ( getResourceState( resource ) == "loaded" ) then
					if ( not startResource( resource ) ) then
						load_failed = "startResource failed" ..resourceName
					end
				else
					load_failed = "unknown resource state [\"" .. getResourceState( resource ) .. "\"]"
				end

				if ( load_failed ) then
					outputDebugString( "Resource could not be started (" .. load_failed .. ").", 3 )
				end
			end
		end
		
		outputDebugString( "Took " .. math.floor( getTickCount( ) - tick ) .. " ms (average is " .. math.floor( ( getTickCount( ) - tick ) / 1000 * 100 ) / 100 .. " seconds) to load all resources." )
	end
)