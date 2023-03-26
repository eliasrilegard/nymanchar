local mod = RegisterMod("uriel-before-gabriel", 1)

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function(_, isContinue)
  if not isContinue then
    -- Set Gabriel as last spawned angel, forcing Uriel to spawn next
    Game():SetStateFlag(GameStateFlag.STATE_GABRIEL_SPAWNED, true)
  end
end)

mod:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, function(_, entityType)
  if entityType == EntityType.ENTITY_URIEL and not Game():GetStateFlag(GameStateFlag.STATE_URIEL_SPAWNED) then
    -- When Uriel first spawns, unset Gabriel spawn state
    Game():SetStateFlag(GameStateFlag.STATE_GABRIEL_SPAWNED, false)
  end
end)
