local mod = LibStub("AceAddon-3.0"):NewAddon("InternalCooldowns");

local options = {
	type = "group",
	args = {}
};

local optionFrames = {};
local ACD3 = LibStub("AceConfigDialog-3.0");

function mod:OnInitialize()
	self.options = options
	self.db = LibStub("AceDB-3.0"):New("InternalCooldownsDB", defaults)
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("InternalCooldowns", options)
	ACD3:AddToBlizOptions("InternalCooldowns")
end;

function mod:RegisterModuleOptions(name, optionTbl, displayName)
	do return end
	options.args[name] = (type(optionTbl) == "function") and optionTbl() or optionTbl
	if not optionFrames.default then
		optionFrames.default = ACD3:AddToBlizOptions("InternalCooldowns", nil, nil, name)
	else
		optionFrames[name] = ACD3:AddToBlizOptions("InternalCooldowns", displayName, "InternalCooldowns", name)
	end
end;