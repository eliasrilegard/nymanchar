local mod = RegisterMod("blindfold", 1)
mod.COLLECTIBLE_BLINDFOLD = Isaac.GetItemIdByName("Blindfold")

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, function(_, player)
  -- If item is picked up
  if player:HasCollectible(mod.COLLECTIBLE_BLINDFOLD) and player:CanShoot() then
    local oldChallenge = Game().Challenge
    Game().Challenge = 6
    player:UpdateCanShoot()
    Game().Challenge = oldChallenge
  end

  -- If item is somehow removed
  if not player:HasCollectible(mod.COLLECTIBLE_BLINDFOLD) and not player:CanShoot() then 
    player:UpdateCanShoot()
  end
end)