--@free_version 
local cloneref = cloneref or function(x) return x end

local game          = cloneref(game)
local http_service  = cloneref(game:GetService("HttpService"))
local players       = cloneref(game:GetService("Players"))
local starter_gui   = cloneref(game:GetService("StarterGui"))

--@types
type loader_config = {
	name: string,
	url: string,
	version: string?,
	author: string?,
}
--@list_game_loaders
local ___loaders: { [number]: loader_config } = {
	[130342654546662] = {
		name    = "sambung kata",
		url     = "https://api.luarmor.net/files/v4/loaders/4b4c6f8fb300d59c59b1f0ce609397e2.lua",
		version = "1.0.0",
		author  = "mas arip, lendowsky",
	},
    [129866685202296] = {
        name    = "last letter",
        url     = "https://api.luarmor.net/files/v4/loaders/ac23c180bd5691977221910e04ff2aa4.lua",
        version = "1.0.0",
        author  = "mas arip, lendowsky",
    }
}

local ___default_loader: loader_config = {
	name    = "---",
	url     = "",
	version = "0.0.0",
	author  = "aths",
}
--@utility
local function __notify(title: string, text: string): ()
	pcall(function()
		starter_gui:SetCore("SendNotification", {
			Title    = title,
			Text     = text,
			Duration = 5,
		})
	end)
end
--@loader
local function __load_script(url: string): boolean
	local success: boolean, result: any = pcall(function()
		local script_content: string = game:HttpGet(url)
		local loaded_function: any = loadstring(script_content)
		
		if loaded_function then
			loaded_function()
			return true
		else
			error("failed to compile script")
		end
	end)
	
	if not success then
		warn("[loader] failed:", result)
		__notify("euphoria loader", "failed to load script")
		return false
	end
	
	return true
end
--@main loader
local current_place_id: number = game.PlaceId
local loader_config: loader_config = ___loaders[current_place_id] or ___default_loader
--@main execution
__load_script(loader_config.url)
