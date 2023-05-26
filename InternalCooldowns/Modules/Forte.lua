local mod = LibStub("AceAddon-3.0"):GetAddon("InternalCooldowns"):NewModule("Forte Cooldown", "AceEvent-3.0")
local lib = LibStub("LibInternalCooldowns-1.0")

if not _G.FW then return end

function mod:OnEnable()
	lib.RegisterCallback(mod, "InternalCooldowns_Proc")
	lib.RegisterCallback(mod, "InternalCooldowns_TalentProc")
end

function mod:OnDisable()
	lib.UnregisterCallback(mod, "InternalCooldowns_Proc")
	lib.UnregisterCallback(mod, "InternalCooldowns_TalentProc")
end

function mod:InternalCooldowns_TalentProc(callback, spellID, start, duration)
	local name, _, icon = GetSpellInfo(spellID)
	FW:HiddenCooldown(name, duration, icon)
end

function mod:InternalCooldowns_Proc(callback, itemID, spellID, start, duration)
	local name = GetSpellInfo(spellID)
	local texture = select(10, GetItemInfo(itemID))
	FW:HiddenCooldown(name, duration, texture)
end
