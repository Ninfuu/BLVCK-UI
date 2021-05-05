local mNameplates = LibStub("AceAddon-3.0"):GetAddon("mNameplates")
if not mNameplates then return end
local plugin = mNameplates:NewModule("UnitHealthPercent", "AceEvent-3.0")
if not plugin then return end

plugin.DisplayName = "Health Percent"
plugin.DisplayIcon = [[Interface\Icons\INV_Mushroom_07]]

local AceGUI 	= LibStub("AceGUI-3.0")
local LSM		= LibStub("LibSharedMedia-3.0")
local Nameplates = LibStub("LibNameplate-1.0")
local UIF
local db

local Cache = {}

local RaidMarkCoords = {
	{0.00, 	0.25,	0.00,	0.25},
	{0.25,	0.50,	0.00,	0.25},
	{0.50, 	0.75,	0.00,	0.25},
	{0.75,	1.00,	0.00,	0.25},
	{0.00,	0.25,	0.25,	0.50},
	{0.25,	0.50,	0.25,	0.50},
	{0.50,	0.75,	0.25,	0.50},
	{0.75,	1.00,	0.25,	0.50},
}

local defaults = {
	profile = {
		Enabled = true,
		
		Attached = {
			["**"] = {
				x = 0,
				y = 1,
				Point = "RIGHT",
				RelPoint = "RIGHT",
			}
		},
		AttachedFrame = "HealthBars",
		
		Font = "accid",
		FontSize = 10,
		FontFlags = "OUTLINE",
		FontColor = {1, 1, 1, 1},		
		FontShadow = true,
		FontShadowX = 1,
		FontShadowY = -1,
		FontShadowColor = {0, 0, 0, 1},
		
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
	mNameplates.RegisterCallback(self, "PlateHPChanged")
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
		data.HealthPercent:SetWidth(0.1)
		data.HealthPercent:SetHeight(0.1)
		data.HealthPercent:Hide()
		tinsert(Cache, data.HealthPercent)
		data.HealthPercent = nil
	end
	
	
end

-- ~~~~~~~~~~~~~~~~~~~~~~
-- Callbacks ~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~

function plugin:ProfileChanged(event)
	db = self.db.profile
	if db.Enabled then
		if not self:IsEnabled() then self:Enable() end
		self:ApplyAllPlates()
	elseif not db.Enabled and self:IsEnabled() then 
		self:Disable() 
	end	
end

function plugin:PlateNew(event, plate, data)	
	local HealthPercent = table.remove(Cache)
	if not HealthPercent then
		HealthPercent = CreateFrame("Frame", nil, data.Background)
		HealthPercent:SetFrameLevel(plate:GetFrameLevel() + mNameplates.Levels.Text)
		local text = HealthPercent:CreateFontString(nil, nil, "GameFontNormal")
		text:SetAllPoints()		
		HealthPercent.text = text
		HealthPercent:Hide()
	end
	HealthPercent:SetParent(data.Background)
	data.HealthPercent = HealthPercent
end

function plugin:PlateShow(event, plate)		
	self:ApplyOnPlate(plate)
end

function plugin:PlateHPChanged(event, plate, data)
	local health, maxHealth = Nameplates:GetHealth(plate), Nameplates:GetHealthMax(plate)	
	if health and maxHealth then
		data.HealthPercent.text:SetText(("%.1f%%"):format(health / maxHealth * 100))
		data.HealthPercent:SetWidth(data.HealthPercent.text:GetStringWidth())
		data.HealthPercent:SetHeight(data.HealthPercent.text:GetStringHeight())
	end
end

function plugin:PlateHide(event, plate, data)
	data.HealthPercent:Hide()
end

-- ~~~~~~~~~~~~~~~~~~~~~~
-- Events ~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~

-- ~~~~~~~~~~~~~~~~~~~~~~
-- Settings ~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~
function plugin:ApplyOnPlate(plate)
	local data = mNameplates:GetExtra(plate)	
	
	local frame = mNameplates:GetAttachFrame(db.AttachedFrame, plate) or plate
	data.HealthPercent:ClearAllPoints()
	data.HealthPercent:SetPoint(db.Attached[db.AttachedFrame].Point, frame, db.Attached[db.AttachedFrame].RelPoint, db.Attached[db.AttachedFrame].x, db.Attached[db.AttachedFrame].y)			
	
	local health, maxHealth = Nameplates:GetHealth(plate), Nameplates:GetHealthMax(plate)
	if health and maxHealth then
		data.HealthPercent.text:SetFont(LSM:Fetch("font", db.Font), db.FontSize, db.FontFlags)
		data.HealthPercent.text:SetTextColor(unpack(db.FontColor))
		if db.FontShadow then
			data.HealthPercent.text:SetShadowOffset(db.FontShadowX, db.FontShadowY)
			data.HealthPercent.text:SetShadowColor(unpack(db.FontShadowColor))
		else
			data.HealthPercent.text:SetShadowOffset(0, 0)
		end
	
		data.HealthPercent.text:SetText(("%.1f%%"):format(health / maxHealth * 100))
		data.HealthPercent:SetWidth(data.HealthPercent.text:GetStringWidth())
		data.HealthPercent:SetHeight(data.HealthPercent.text:GetStringHeight())
		data.HealthPercent:Show()
	else
		data.HealthPercent:Hide()
	end
end

function plugin:ApplyAllPlates()
	for i, plate in mNameplates:IteratePlates() do
		self:ApplyOnPlate(plate)
	end
end

-- ~~~~~~~~~~~~~~~~~~~~~~
-- API ~~~~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~
function plugin:GetAttachFrame(plate)
	local data = mNameplates:GetExtra(plate)
	return data.HealthPercent
end

-- ~~~~~~~~~~~~~~~~~~~~~~
-- Options ~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~
do
	local function Callback()
		plugin:ApplyAllPlates()
	end
	
	local FontFlagList = {
		OUTLINE = "Outline",
		THICKOUTLINE = "Thick Outline",
		MONOCHROME = "Monochrome",
		NONE = "None",
	}

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
					
					local group = UIF:InlineGroup("Font")
					group:AddChild(UIF:LSMDropdown("font", "Font", db, "Font", Callback, 0.5))
					group:AddChild(UIF:Dropdown("Flags", db, "FontFlags", Callback, FontFlagList, 0.5))
					group:AddChild(UIF:Slider("Size", db, "FontSize", 1, 50, 1, Callback, 0.5))
					group:AddChild(UIF:NewLine())
					
					group:AddChild(UIF:CheckBox("Enable Shadow", db, "FontShadow", Callback, nil, 0.5))
					group:AddChild(UIF:ColorSelect("Shadow Color", db, "FontShadowColor", Callback, false, 0.5))
					group:AddChild(UIF:Slider("Shadow Offset X", db, "FontShadowX", -30, 30, 0.1, Callback, 0.5))
					group:AddChild(UIF:Slider("Shadow Offset Y", db, "FontShadowY", -30, 30, 0.1, Callback, 0.5))
					g:AddChild(group)
					
					return g
				end
			}
		}
		return options
	end
end