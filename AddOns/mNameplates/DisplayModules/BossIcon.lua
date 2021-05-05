local mNameplates = LibStub("AceAddon-3.0"):GetAddon("mNameplates")
if not mNameplates then return end
local plugin = mNameplates:NewModule("BossIcon")
if not plugin then return end

plugin.DisplayName = "Boss Icon"
plugin.DisplayIcon = [[Interface\TARGETINGFRAME\UI-TargetingFrame-Skull]]

local AceGUI 	= LibStub("AceGUI-3.0")
local LSM		= LibStub("LibSharedMedia-3.0")
local Nameplates = LibStub("LibNameplate-1.0")
local UIF
local db

local Cache = {}

local defaults = {
	profile = {
		Enabled = true,
		
		Attached = {
			["**"] = {
				x = 0,
				y = 0,
				Point = "RIGHT",
				RelPoint = "LEFT",
			}
		},
		AttachedFrame = "NAMEPLATE",
		
		Size = 15,
		Alpha = 1,
	},
	global = {
	}
}

function plugin:OnInitialize()	
	self.db = mNameplates.db:RegisterNamespace(self:GetName(), defaults)
	db = self.db.profile
	
	self.db.RegisterCallback(self, "OnProfileChanged", "ProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "ProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "ProfileChanged")	
	
	self:SetEnabledState(db.Enabled)
	
	UIF = LibStub("LibGUIFactory-1.0"):GetFactory("mNameplates")
end

function plugin:OnEnable()
	mNameplates.RegisterCallback(self, "PlateNew")
	mNameplates.RegisterCallback(self, "PlateShow")
	mNameplates.RegisterCallback(self, "PlateHide")
	mNameplates.RegisterCallback(self, "ModuleStateChanged", "ApplyAllPlates")
	
	for i, plate in mNameplates:IteratePlates() do		
		local data = mNameplates:GetExtra(plate)
		if data then
			self:PlateNew("PlateNew", plate, data)
			self:PlateShow("PlateShow", plate, data)
		end
	end
	
	mNameplates.Callbacks:Fire("ModuleStateChanged", self)
end

function plugin:OnDisable()	
	mNameplates.UnregisterAllCallbacks(self)
	
	for i, plate in mNameplates:IteratePlates() do
		local data = mNameplates:GetExtra(plate)
		data.BossIcon:ClearAllPoints()
		data.BossIcon:SetWidth(0)
		data.BossIcon:SetHeight(0)
		data.BossIcon:Hide()
		tinsert(Cache, data.BossIcon)
		data.BossIcon = nil
	end
	
	
end

-- ~~~~~~~~~~~~~~~~~~~~~~
-- Callbacks ~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~

function plugin:ProfileChanged(event)
	db = self.db.profile
	if db.Enabled and not self:IsEnabled() then 
		self:Enable()
		self:ApplyAllPlates()
	elseif not db.Enabled and self:IsEnabled() then 
		self:Disable()
	end	
end

function plugin:PlateNew(event, plate, data)	
	local BossIcon = table.remove(Cache)
	if not BossIcon then
		BossIcon = CreateFrame("Frame", nil, data.Background)
		BossIcon:SetFrameLevel(plate:GetFrameLevel() + mNameplates.Levels.Icon)
		local t = BossIcon:CreateTexture(nil, "ARTOWRK")
		t:SetAllPoints()
		t:SetTexture([[Interface\TARGETINGFRAME\UI-TargetingFrame-Skull]])
		BossIcon.Texture = t
		BossIcon:Hide()
	end
	BossIcon:SetParent(data.Background)
	data.BossIcon = BossIcon
end

function plugin:PlateShow(event, plate, data)		
	self:ApplyOnPlate(plate, data)
end

function plugin:PlateHide(event, plate, data)
	data.BossIcon:Hide()
end

-- ~~~~~~~~~~~~~~~~~~~~~~
-- Events ~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~

-- ~~~~~~~~~~~~~~~~~~~~~~
-- Settings ~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~
function plugin:ApplyOnPlate(plate, data)
	local frame = mNameplates:GetAttachFrame(db.AttachedFrame, plate) or plate
	data.BossIcon:ClearAllPoints()
	data.BossIcon:SetPoint(db.Attached[db.AttachedFrame].Point, frame, db.Attached[db.AttachedFrame].RelPoint, db.Attached[db.AttachedFrame].x, db.Attached[db.AttachedFrame].y)			
	
	if Nameplates:IsBoss(plate) then		
		data.BossIcon:SetAlpha(db.Alpha)
		data.BossIcon:SetWidth(db.Size)
		data.BossIcon:SetHeight(db.Size)
		data.BossIcon:Show()
	else
		data.BossIcon:SetWidth(0.1)
		data.BossIcon:SetHeight(0.1)
		data.BossIcon:Hide()
	end
end

function plugin:ApplyAllPlates()
	for i, plate in mNameplates:IteratePlates() do
		self:ApplyOnPlate(plate, mNameplates:GetExtra(plate))
	end
end

-- ~~~~~~~~~~~~~~~~~~~~~~
-- API ~~~~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~
function plugin:GetAttachFrame(plate)
	local data = mNameplates:GetExtra(plate)
	return data.BossIcon
end

-- ~~~~~~~~~~~~~~~~~~~~~~
-- Options ~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~
do
	local function Callback()
		plugin:ApplyAllPlates()
	end

	local options
	function plugin:GetOptions()
		if options then return options end
		options = {
			{
				data = {{text = "Modules", value = "Modules"}, {text = plugin.DisplayName, value = plugin.DisplayName}},
				icon = self.DisplayIcon,
				func = function()
					local g = AceGUI:Create("SimpleGroup")
					g:SetLayout("Flow")
					g:SetFullWidth(true)										
					
					g:AddChild(UIF:CheckBox("Enabled", db, "Enabled", function() 
						if db.Enabled and not plugin:IsEnabled() then plugin:Enable()
						elseif not db.Enabled and plugin:IsEnabled() then plugin:Disable() end
					end))
					
					local group = UIF:InlineGroup("Attatch")
					g:AddChild(group)
					group:AddChild(UIF:Dropdown("Frame", db, "AttachedFrame", Callback, mNameplates:GetAttachList(self), 0.5, true))
					
					local group = UIF:InlineGroup("Position")
					g:AddChild(group)
					group:AddChild(UIF:Slider("X", db.Attached[db.AttachedFrame], "x", -300, 300, 0.1, Callback, 0.5))
					group:AddChild(UIF:Slider("Y", db.Attached[db.AttachedFrame], "y", -300, 300, 0.1, Callback, 0.5))
					group:AddChild(UIF:Dropdown("Point", db.Attached[db.AttachedFrame], "Point", Callback, mNameplates:GetAnchorList(), 0.5, true))
					group:AddChild(UIF:Dropdown("Relative Point", db.Attached[db.AttachedFrame], "RelPoint", Callback, mNameplates:GetAnchorList(), 0.5, true))
					
					local group = UIF:InlineGroup(" ")
					g:AddChild(group)
					group:AddChild(UIF:Slider("Size", db, "Size", 1, 100, 0.1, Callback, 0.5))
					group:AddChild(UIF:Slider("Alpha", db, "Alpha", 0, 1, 0.01, Callback, 0.5))
					
					return g
				end
			}
		}
		return options
	end
end