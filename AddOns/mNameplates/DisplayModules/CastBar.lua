local mNameplates = LibStub("AceAddon-3.0"):GetAddon("mNameplates")
if not mNameplates then return end
local plugin = mNameplates:NewModule("CastBar", "AceEvent-3.0", "AceHook-3.0")
if not plugin then return end

plugin.DisplayName = "Cast Bar"
plugin.DisplayIcon = [[Interface\Icons\inv_misc_bandage_frostweave_heavy]]

local AceGUI 	= LibStub("AceGUI-3.0")
local LSM		= LibStub("LibSharedMedia-3.0")
local Nameplates = LibStub("LibNameplate-1.0")
local UIF
local db

local Cache = {}

local defaults = {
	profile = {
		Enabled = true,
		x = 0,
		y = 20,
		Width = 125,
		Height = 12,
		ColorInteruptable = {1, 1, 1, 1},
		ColorNotInteruptable = {1, 0, 0, 1},
		Attached = {
			["**"] = {
				x = 0,
				y = 0,
				Point = "TOP",
				RelPoint = "BOTTOM",
			}
		},
		AttachedFrame = "HealthBars",
		Texture = "HalD",
		
		Font = "accid",
		FontSize = 10,
		FontFlags = "OUTLINE",
		FontColor = {1, 1, 1, 1},
		FontShadow = true,
		FontShadowX = 1,
		FontShadowY = -1,
		FontShadowColor = {0, 0, 0, 1},
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
	
	self:RegisterEvent("UNIT_SPELLCAST_START", "SpellCast")
	self:RegisterEvent("UNIT_SPELLCAST_STOP", "SpellCast")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", "SpellChannel")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", "SpellChannel")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", "SpellChannel")
	
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
	print("disable", self)
	mNameplates.UnregisterAllCallbacks(self)
	for i, plate in mNameplates:IteratePlates() do
		local data = mNameplates:GetExtra(plate)
		data.CastBar:ClearAllPoints()
		data.CastBar:Hide()
		data.CastBar:SetWidth(0.01)
		data.CastBar:SetHeight(0.01)
		tinsert(Cache, data.CastBar)
		data.CastBar = nil
	end
	
	mNameplates.Callbacks:Fire("ModuleStateChanged", self)
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

local function CastBarChanged(self, value)
	local plate = self:GetParent()
	local data = mNameplates:GetExtra(plate)	
	data.CastBar:SetValue(value)
	if data.CastBar.EndTime then
		data.CastBar.SpellTime:SetText(("%.1f"):format((data.CastBar.EndTime / 1000 - GetTime())))
	end
end

function plugin:PlateNew(event, plate, data)	
	local bar = table.remove(Cache)
	self:HookScript(plate.DefaultItems.CastBar, "OnValueChanged", CastBarChanged)
	if not bar then
		bar = CreateFrame("StatusBar", nil, data.Background)
		bar:SetMinMaxValues(0, 1)
		data.CastBar = bar	
				
		local text = bar:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		text:SetJustifyH("LEFT")
		text:SetPoint("TOPLEFT", 2, 0)
		text:SetPoint("BOTTOMLEFT", 2, 0)
		bar.SpellTime = text
		
		text = bar:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		text:SetJustifyH("RIGHT")
		text:SetPoint("TOPRIGHT", -2, 0)
		text:SetPoint("BOTTOMLEFT", bar.SpellTime, "BOTTOMRIGHT", 2, 0)
		bar.SpellText = text
		
		self:ApplyOnPlate(plate, data)
	end	
	bar:SetParent(data.Background)
	bar:Hide()
	data.CastBar = bar	
end


function plugin:PlateShow(event, plate, data)
	self:ApplyOnPlate(plate, data)
end

function plugin:PlateHide(event, plate, data)
	data.CastBar:Hide()
end

-- ~~~~~~~~~~~~~~~~~~~~~~
-- Events ~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~
function plugin:SpellCast(event, unit)
	if unit == "player" then return end
	if event == "UNIT_SPELLCAST_START" then
		local plate = Nameplates:GetNameplateByUnit(unit)
			if plate then
			local data = mNameplates:GetExtra(plate)
			local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castID, interrupt = UnitCastingInfo(unit)		
			data.CastBar:SetMinMaxValues(0, (endTime - startTime) / 1000)
			data.CastBar.EndTime = endTime
			data.CastBar.SpellText:SetText(displayName)
			data.CastBar:Show()
		end
		
	elseif event == "UNIT_SPELLCAST_STOP" then
		if plate then
			local plate = Nameplates:GetNameplateByUnit(unit)
			local data = mNameplates:GetExtra(plate)
			data.CastBar:Hide()
		end
	end
end

function plugin:SpellChannel(event, unit)
	if unit == "player" then return end
	if event == "UNIT_SPELLCAST_CHANNEL_START" then
		if plate then
			local plate = Nameplates:GetNameplateByUnit(unit)
			local data = mNameplates:GetExtra(plate)
			local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castID, interrupt = UnitChannelInfo(unit)
			data.CastBar:SetMinMaxValues(0, (endTime - startTime) / 1000)
			data.CastBar.EndTime = endTime
			data.CastBar.SpellText:SetText(displayName)
			data.CastBar:Show()
		end
	
	elseif event == "UNIT_SPELLCAST_CHANNEL_STOP" then
		if plate then
			local plate = Nameplates:GetNameplateByUnit(unit)
			local data = mNameplates:GetExtra(plate)
			data.CastBar:Hide()
		end
	end
end

-- ~~~~~~~~~~~~~~~~~~~~~~
-- Settings ~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~
function plugin:ApplyOnPlate(plate)
	local data = mNameplates:GetExtra(plate)	
	local frame = mNameplates:GetAttachFrame(db.AttachedFrame, plate) or plate
	data.CastBar:ClearAllPoints()
	data.CastBar:SetPoint(db.Attached[db.AttachedFrame].Point, frame, db.Attached[db.AttachedFrame].RelPoint, db.Attached[db.AttachedFrame].x, db.Attached[db.AttachedFrame].y)			
	data.CastBar:SetHeight(db.Height)
	data.CastBar:SetWidth(db.Width)
	
	data.CastBar:SetStatusBarTexture(LSM:Fetch("statusbar", db.Texture))
	data.CastBar:SetStatusBarColor(unpack(db.ColorInteruptable))
	
	data.CastBar.SpellText:SetFont(LSM:Fetch("font", db.Font), db.FontSize, db.FontFlags)
	data.CastBar.SpellTime:SetFont(LSM:Fetch("font", db.Font), db.FontSize, db.FontFlags)
	data.CastBar.SpellText:SetTextColor(unpack(db.FontColor))
	data.CastBar.SpellTime:SetTextColor(unpack(db.FontColor))
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
	return data.HealthBar
end

-- ~~~~~~~~~~~~~~~~~~~~~~
-- Options ~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~
do
	local function Callback()
		plugin:ApplyAllPlates()
	end
	
	local function Enable()
	end
	
	local function Disable()
	end

	local options
	function plugin:GetOptions()
		if options then return options end
		options = {
			{
				data = {{text = "Modules", value = "Modules"}, {text = self.DisplayName, value = self.DisplayName, order = 1}},
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
					group:AddChild(UIF:Slider("Width", db, "Width", 0, 300, 0.1, Callback, 0.5))
					group:AddChild(UIF:Slider("Height", db, "Height", 0, 300, 0.1, Callback, 0.5))
					group:AddChild(UIF:Dropdown("Point", db.Attached[db.AttachedFrame], "Point", Callback, mNameplates:GetAnchorList(), 0.5, true))
					group:AddChild(UIF:Dropdown("Relative Point", db.Attached[db.AttachedFrame], "RelPoint", Callback, mNameplates:GetAnchorList(), 0.5, true))
					
					local group = UIF:InlineGroup("Colors")
					g:AddChild(group)
					group:AddChild(UIF:ColorSelect("Interuptable", db, "ColorInteruptable", Callback, true, 0.3))
					group:AddChild(UIF:ColorSelect("Not Interuptable", db, "ColorNotInteruptable", Callback, true, 0.3))
				
					
					g:AddChild(UIF:LSMDropdown("statusbar", "Texture", db, "Texture", Callback, 0.5))
					
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
			},
		}
		return options
	end
end
