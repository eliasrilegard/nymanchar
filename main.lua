local mod = RegisterMod("nyman char", 1)
local game = Game()

local playerTypeNyman = Isaac.GetPlayerTypeByName("Nyman")
local runStarted = false

local modRNG = RNG()
function random(min,max)
	if min ~= nil and max ~= nil then
		return math.floor(modRNG:RandomFloat() * (max - min + 1) + min)
	elseif min ~= nil then
		return math.floor(modRNG:RandomFloat() * (min + 1))
	end
	return modRNG:RandomFloat()
end

function mod:getPlayers()
	local players = {}
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		players[i] = player
	end
	return players
end

function mod:playerSetup(player)
   local costume = Isaac.GetCostumeIdByPath("gfx/characters/nyman_hair" .. random(1,40) .. ".anm2")
   if player:GetPlayerType() == playerTypeNyman then
      player:SetPocketActiveItem(Isaac.GetItemIdByName("Smelter"))
      player:AddTrinket(random(1,187))
      player:AddNullCostume(costume)
   else
      player:TryRemoveNullCostume(costume)
   end
end

function mod:postGameStarted(isContinue)
   for _,player in pairs(mod:getPlayers()) do
      mod:playerSetup(player)
   end
   runStarted = true
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.postGameStarted)

function mod:postPlayerInit(player)
   modRNG:SetSeed(player:GetDropRNG():GetSeed(), 0)
   if runStarted then
      mod:playerSetup(player)
   end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.postPlayerInit)