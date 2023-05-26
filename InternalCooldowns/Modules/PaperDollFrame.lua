local mod = LibStub("AceAddon-3.0"):GetAddon("InternalCooldowns"):NewModule("PaperDollFrame", "AceEvent-3.0")
local lib = LibStub("LibInternalCooldowns-1.0")

local slots = {
	[0] = "CharacterAmmoSlot",
	[1] = "CharacterHeadSlot",
	[2] = "CharacterNeckSlot",
	[3] = "CharacterShoulderSlot",
	[4] = "CharacterShirtSlot",
	[5] = "CharacterChestSlot",
	[6] = "CharacterWaistSlot",
	[7] = "CharacterLegsSlot",
	[8] = "CharacterFeetSlot",
	[9] = "CharacterWristSlot",
	[10]= "CharacterHandsSlot",
	[11]= "CharacterFinger0Slot",
	[12]= "CharacterFinger1Slot",
	[13]= "CharacterTrinket0Slot",
	[14]= "CharacterTrinket1Slot",
	[15]= "CharacterBackSlot",
	[16]= "CharacterMainHandSlot",
	[17]= "CharacterSecondaryHandSlot",
	[18]= "CharacterRangedSlot",
	[19]= "CharacterTabardSlot"
}

local equippedItems = {}

function mod:OnEnable()
	self:RegisterEvent("UNIT_INVENTORY_CHANGED")
	self:UNIT_INVENTORY_CHANGED("player")
	lib.RegisterCallback(mod, "InternalCooldowns_Proc")	
end

function mod:OnDisable()
	self:UnregisterEvent("UNIT_INVENTORY_CHANGED")
	lib.UnregisterCallback(mod, "InternalCooldowns_Proc")
end

function mod:UNIT_INVENTORY_CHANGED(unit)
	if unit == "player" then
		wipe(equippedItems)
		for i = 1, 19 do
			local link = GetInventoryItemLink(unit, i)
			if link then
				equippedItems[tonumber(link:match("item:(%d+)") or 0)] = i
			end			
		end
	end
end

function mod:InternalCooldowns_Proc(callback, itemID, spellID, start, duration)
	local slot = equippedItems[itemID]
	if slot then
		_G[slots[slot] .. "Cooldown"]:SetCooldown(start, duration)
	end
end
