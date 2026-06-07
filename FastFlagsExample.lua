--[[
	FastFlags Integration Example for Roblox
	Shows how to use the FastFlags system in your game
]]

local FastFlags = require(game:GetService("ServerScriptService"):WaitForChild("FastFlags"))

-- Initialize with your flags
local flagSystem = FastFlags.new({
	EnableNewFeature = true,
	EnableDebugMode = false,
	EnableCustomPhysics = true,
	RenderOptimization = true,
	NetworkCompression = true,
})

-- Main game loop - call this in RunService.Heartbeat or RunService.RenderStepped
local lastUpdate = tick()

game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
	-- Update cache periodically for memory efficiency
	flagSystem:UpdateCache()
	
	-- Your game logic here
	if flagSystem:Get("EnableNewFeature") then
		-- Execute new feature code
	end
	
	if flagSystem:Get("RenderOptimization") then
		-- Optimized rendering path
	end
	
	-- Print stats every 10 seconds
	local now = tick()
	if (now - lastUpdate) > 10 then
		local stats = flagSystem:GetStats()
		print("FastFlags Stats:", stats)
		lastUpdate = now
	end
end)

-- Network communication example (update flags from server/client)
local function updateFlagsFromNetwork(flagsData)
	flagSystem:SetBatch(flagsData)
end

-- Client-side usage (in LocalScript)
local function getClientFlags()
	return {
		EnableNewFeature = flagSystem:Get("EnableNewFeature"),
		RenderOptimization = flagSystem:Get("RenderOptimization"),
	}
end

return {
	flagSystem = flagSystem,
	updateFlagsFromNetwork = updateFlagsFromNetwork,
	getClientFlags = getClientFlags,
}
