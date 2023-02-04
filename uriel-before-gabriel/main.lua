local mod = RegisterMod("uriel-before-gabriel", 1)

function mod:preSpawn(entityType, variant, subType, _, _, _, seed)
  local game = Game()
  local roomType = game:GetRoom():GetType()
  
  -- Only activate effect on Angel rooms and Super Secret rooms
  if roomType ~= RoomType.ROOM_ANGEL and roomType ~= RoomType.ROOM_SUPERSECRET then
    return nil
  end

  if entityType ~= EntityType.ENTITY_URIEL and entityType ~= EntityType.ENTITY_GABRIEL then
    return nil
  end

  -- Guard against fallen angels etc
  if variant ~= 0 then
    return nil
  end

  local hasKey1 = false
  local hasKey2 = false

  for i = 0, game:GetNumPlayers() - 1 do
    local player = game:GetPlayer(i)

    -- Check if any player has any key pieces
    hasKey1 = hasKey1 or player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_1)
    hasKey2 = hasKey2 or player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_2)
  end

  -- No key pieces found, force Uriel
  if not hasKey1 then
    return { EntityType.ENTITY_URIEL, variant, subType, seed }
  end
    
  -- Key Piece 1 exists, force Gabriel
  if not hasKey2 then
    return { EntityType.ENTITY_GABRIEL, variant, subType, seed }
  end
  
  -- Both key pieces exist, no change 
  return nil
end

mod:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, mod.preSpawn)