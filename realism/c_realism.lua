addEventHandler( "onClientResourceStart", resourceRoot,
	function( )
		setAmbientSoundEnabled( "general", false )
        setAmbientSoundEnabled( "gunfire", false )
        --setFarClipDistance(2000)
        setBlurLevel(10)
	end
)