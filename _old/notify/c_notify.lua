local screenWidth, screenHeight = guiGetScreenSize()
local browserSizeX, browserSizeY = 300, 700

local indexHTML = "http://mta/local/web/index.html" --"http://mta/local/web/index.html"
local webBrowser = nil 

---if created from server part
local function showWebView(forceClose)
	if(webBrowser ~= nil and forceClose) then
		destroyElement(webBrowser)
		--showCursor(false)
	end

	webBrowser = createBrowser(browserSizeX, browserSizeY, true, true)
	--requestBrowserDomains({indexHTML})
	--toggleBrowserDevTools(webBrowser, true)
	--showCursor(true)

	addEventHandler("onClientBrowserCreated", webBrowser, 
		function()
			loadBrowserURL(webBrowser,indexHTML)
			addEventHandler("onClientRender", root,
				function()
					dxDrawImage(screenWidth - browserSizeX, screenHeight - browserSizeY, browserSizeX, browserSizeY, webBrowser, 0, 0, 0, tocolor(255,255,255,255), true)
				end)
		end)
end
addEventHandler("onClientResourceStart", getRootElement(), showWebView)


function notifyPlayer(title, sender, message, icon, flashing)
	executeBrowserJavascript(webBrowser, string.format("notify('%s', '%s', '%s', %d, '%s')", title, sender, message, icon, tostring(flashing)))
end
addEvent("notify_notifyPlayer", true)
addEventHandler("notify_notifyPlayer", root, notifyPlayer)