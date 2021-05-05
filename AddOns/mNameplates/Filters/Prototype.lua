local mNameplates = LibStub("AceAddon-3.0"):GetAddon("mNameplates")
if not mNameplates then return end
mNameplates.Filters = mNameplates.Filters or {}

local FilterModuleProt = {}

function mNameplates:NewFilterModule(moduleName, ...)	
	local filter = self:NewModule(moduleName, FilterModuleProt, ...)
	tinsert(self.Filters, filter)
	return filter
end

function mNameplates:FilterChanged()
	for i, plate in self:IteratePlates() do
		self:LibNameplate_RecycleNameplate("LibNameplate_RecycleNameplate", plate)
		self:LibNameplate_NewNameplate("LibNameplate_NewNameplate", plate)
	end
end

function FilterModuleProt:OnInitialize()
end

function FilterModuleProt:OnEnable()
end

function FilterModuleProt:OnDisable()
end

function FilterModuleProt:RunFilter()
	error(self:GetName().." does not supply  a RunFilter(plate) function")
end