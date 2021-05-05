local mNameplates = LibStub("AceAddon-3.0"):GetAddon("mNameplates")
if not mNameplates then return end

local DisplayModuleProt = {}

function mNameplates:NewDisplayModule(moduleName, ...)
	return self:NewModule(moduleName, DisplayModuleProt, ...)
end

function DisplayModuleProt:OnInitialize()
end

function DisplayModuleProt:OnEnable()
end

function DisplayModuleProt:OnDisable()
end

function DisplayModuleProt:GetAttachFrame()
	error(self:GetName().." does not supply a GetAttachedFrame() function")
end