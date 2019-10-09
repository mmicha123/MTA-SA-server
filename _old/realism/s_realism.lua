addEventHandler("onResourceStart", resourceRoot,
	function( )
		setGameType("Modeflick")
        setFarClipDistance(2000)

		setWeaponProperty( 22, "std", "flags", 0x000020 )
        setWeaponProperty( 22, "pro", "flags", 0x000020 )
        setWeaponProperty( 22, "pro", "flags", 0x000800 )
		
		setWeaponProperty( 23, "std", "flags", 0x000020 )
        setWeaponProperty( 23, "pro", "flags", 0x000020 )
        setWeaponProperty( 23, "poor", "accuracy", 100 )
		
		setWeaponProperty( 24, "std", "flags", 0x000020 )
		setWeaponProperty( 24, "pro", "flags", 0x000020 )

		setWeaponProperty( 25, "std", "flags", 0x000020 )
		setWeaponProperty( 25, "pro", "flags", 0x000020 )
		
		setWeaponProperty( 26, "std", "flags", 0x000020 )
        setWeaponProperty( 26, "pro", "flags", 0x000020 )
        setWeaponProperty( 26, "pro", "flags", 0x000800 )

		setWeaponProperty( 27, "std", "flags", 0x000020 )
		setWeaponProperty( 27, "pro", "flags", 0x000020 )

		setWeaponProperty( 28, "std", "flags", 0x000020 )
        setWeaponProperty( 28, "pro", "flags", 0x000020 )
        setWeaponProperty( 28, "pro", "flags", 0x000800 )

		setWeaponProperty( 29, "std", "flags", 0x000020 )
        setWeaponProperty( 29, "pro", "flags", 0x000020 )
        setWeaponProperty( 29, "pro", "accuracy", 99 )

		setWeaponProperty( 30, "std", "flags", 0x000020 )
        setWeaponProperty( 30, "pro", "flags", 0x000020 )

        setWeaponProperty( 31, "std", "flags", 0x000020 )
        setWeaponProperty( 31, "pro", "flags", 0x000020 )

        setWeaponProperty( 33, "std", "flags", 0x000020 )
        setWeaponProperty( 33, "pro", "flags", 0x000020 )
        setWeaponProperty( 33, "pro", "flags", 0x000020 )

        setWeaponProperty( 33, "pro", "flags", 0x000020 )

    end
)