local screenWidth, screenHeight = guiGetScreenSize()

local indexHTML = "http://mta/local/web/index.html"
local webBrowser = nil

---if created from server part
local function showWebView(forceClose)
	if(webBrowser ~= nil and forceClose) then
		destroyElement(webBrowser)
		showCursor(false)
	end

	webBrowser = createBrowser(screenWidth, screenHeight, true, false)
	showCursor(true)

	
	addEventHandler("onClientBrowserCreated", webBrowser, 
		function()
			loadBrowserURL(browser, indexHTML)
			addEventHandler("onClientRender", root, 
				function()
					dxDrawImage(0, 0, screenWidth, screenHeight, webBrowser, 0, 0, 0, tocolor(255,255,255,255), true)
				end)
		end)
end
addEvent("resource_showGUI", true)
addEventHandler("resource_showGUI", root, showWebView)



---callback function
---in javaScript call this event (mta.triggerEvent("callbackMTA", [parameter.....]))
function callbackMTA()

end
addEvent("account_signup", true)
addEventHandler("account_signup", root, callbackMTA)


function sendError(msg) 
	executeBrowserJavascript(webBrowser, "document.getElementById("errorMessage").innerHTML = '" ..msg .. "'")
end