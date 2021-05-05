local mNameplates = LibStub("AceAddon-3.0"):GetAddon("mNameplates")
if not mNameplates then return end
local plugin = mNameplates:NewModule("HealthBars")
if not plugin then return end

plugin.DisplayName = "Health Bars"
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
		Width = 180,
		Height = 12,
		Texture = "HalD",
		Colors = {
			["**"] = {
				["**"] = {
					FRIENDLY = {73/255, 255/255, 81/255, 1},
					NEUTRAL = {255/255, 252/255, 92/255, 1},
					HOSTILE = {255/255, 36/255, 0, 1},
				}
			},
			PLAYER = {
				UseHostileClassColor = true,
				NORMAL = {
					FRIENDLY = {103/255, 134/255, 255/255, 1},
				},
			}
		}
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
	mNameplates.RegisterCallback(self, "PlateMouseover")
	mNameplates.RegisterCallback(self, "PlateMouseLeave")
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
		data.HealthBar:ClearAllPoints()
		data.HealthBar:Hide()
		tinsert(Cache, data.HealthBar)
		data.HealthBar = nil
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

function plugin:PlateNew(event, plate, data)	
	local bar = table.remove(Cache)
	if not bar then
		bar = CreateFrame("StatusBar", nil, data.Background)
		local highlight = bar:CreateTexture(nil, "OVERLAY")
		highlight:SetAllPoints(true)
		--highlight:SetPoint("LEFT", bar, "RIGHT")
		--highlight:SetWidth(100)
		--highlight:SetHeight(100)
		highlight:SetVertexColor(1, 1, 1, 0.5)		
		highlight:Hide()
		bar.Highlight = highlight
		data.HealthBar = bar
		self:ApplyOnPlate(plate, data)
	end	
	bar:SetParent(data.Background)
	bar:Hide()
	bar:SetPoint("BOTTOMLEFT")
	bar:SetPoint("BOTTOMRIGHT")
	data.HealthBar = bar	
end

function plugin:PlateHPChanged(event, plate, data)
	local health, maxHealth = Nameplates:GetHealth(plate), Nameplates:GetHealthMax(plate)
	data.HealthBar:SetMinMaxValues(0, maxHealth)
	data.HealthBar:SetValue(health)
end

function plugin:PlateShow(event, plate, data)
	self:ApplyOnPlate(plate, data)
	self:PlateHPChanged("PlateHPChanged", plate, data)	
end

function plugin:PlateMouseover(event, plate, data)
	data.HealthBar.Highlight:Show()
end

function plugin:PlateMouseLeave(event, plate, data)
	data.HealthBar.Highlight:Hide()
end

function plugin:PlateHide(event, plate, data)
	data.HealthBar:Hide()
end

-- ~~~~~~~~~~~~~~~~~~~~~~
-- Events ~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~

-- ~~~~~~~~~~~~~~~~~~~~~~
-- Settings ~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~
function plugin:ApplyOnPlate(plate)
	local data = mNameplates:GetExtra(plate)
	data.HealthBar:SetHeight(db.Height)
	data.HealthBar:SetStatusBarTexture(LSM:Fetch("statusbar", db.Texture))
	data.HealthBar.Highlight:SetTexture(LSM:Fetch("statusbar", db.Texture))
	--data.HealthBar.Highlight:SetWidth(db.Width)
	--data.HealthBar.Highlight:SetHeight(db.Height)
	data.HealthBar:Show()
	
	local unitType = Nameplates:GetType(plate)
	local reaction = Nameplates:GetReaction(plate)
	if reaction and unitType then
		if unitType == "NPC" then
			if Nameplates:IsBoss(plate) then
				data.HealthBar:SetStatusBarColor(unpack(db.Colors.NPC.BOSS[reaction]))
			elseif Nameplates:IsElite(plate) then
				data.HealthBar:SetStatusBarColor(unpack(db.Colors.NPC.ELITE[reaction]))
			else
				data.HealthBar:SetStatusBarColor(unpack(db.Colors.NPC.NORMAL[reaction]))
			end
		else			
			if (reaction == "HOSTILE" and db.Colors.PLAYER.UseHostileClassColor) then								
				local class = Nameplates:GetClass(plate)
				if class then
					local c = RAID_CLASS_COLORS[class]
					data.HealthBar:SetStatusBarColor(c.r, c.g, c.b)
				else
					data.HealthBar:SetStatusBarColor(unpack(db.Colors.PLAYER.NORMAL[reaction]))
				end
			else
				data.HealthBar:SetStatusBarColor(unpack(db.Colors.PLAYER.NORMAL[reaction]))
			end
		end
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
				data = {{text = "Modules", value = "Modules"}, {text = self.DisplayName, value = "HealthBars", order = 1}},
				icon = self.DisplayIcon,
				func = function()
					local g = AceGUI:Create("SimpleGroup")
					g:SetLayout("Flow")
					g:SetFullWidth(true)
					
					g:AddChild(UIF:CheckBox("Enabled", db, "Enabled", function() 
						if db.Enabled and not plugin:IsEnabled() then plugin:Enable()
						elseif not db.Enabled and plugin:IsEnabled() then plugin:Disable() end
					end))
					
					local group = UIF:InlineGroup("Position and Size")
					g:AddChild(group)
					group:AddChild(UIF:Slider("X", db, "x", -300, 300, 0.1, Callback, 0.5))
					group:AddChild(UIF:Slider("Y", db, "y", -300, 300, 0.1, Callback, 0.5))
					group:AddChild(UIF:Slider("Width", db, "Width", -300, 300, 0.1, Callback, 0.5))
					group:AddChild(UIF:Slider("Height", db, "Height", -300, 300, 0.1, Callback, 0.5))
					
					local group = UIF:InlineGroup("Colors")
					g:AddChild(group)
					local group2 = UIF:InlineGroup2("NPCs")
					group:AddChild(group2)
					group2:AddChild(UIF:Text1(" ", nil, nil, nil, nil, nil, 0.25))
					group2:AddChild(UIF:Text1("Friedly", nil, nil, nil, nil, nil, 0.25))
					group2:AddChild(UIF:Text1("Neutral", nil, nil, nil, nil, nil, 0.25))
					group2:AddChild(UIF:Text1("Hostile", nil, nil, nil, nil, nil, 0.25))
					group2:AddChild(UIF:Text1("Boss", nil, nil, nil, nil, nil, 0.25))
					group2:AddChild(UIF:ColorSelect("", db.Colors.NPC.BOSS, "FRIENDLY", Callback, true, 0.25))
					group2:AddChild(UIF:ColorSelect("", db.Colors.NPC.BOSS, "NEUTRAL", Callback, true, 0.25))
					group2:AddChild(UIF:ColorSelect("", db.Colors.NPC.BOSS, "HOSTILE", Callback, true, 0.25))
					group2:AddChild(UIF:Text1("Elite", nil, nil, nil, nil, nil, 0.25))
					group2:AddChild(UIF:ColorSelect("", db.Colors.NPC.ELITE, "FRIENDLY", Callback, true, 0.25))
					group2:AddChild(UIF:ColorSelect("", db.Colors.NPC.ELITE, "NEUTRAL", Callback, true, 0.25))
					group2:AddChild(UIF:ColorSelect("", db.Colors.NPC.ELITE, "HOSTILE", Callback, true, 0.25))
					group2:AddChild(UIF:Text1("Normal", nil, nil, nil, nil, nil, 0.25))
					group2:AddChild(UIF:ColorSelect("", db.Colors.NPC.NORMAL, "FRIENDLY", Callback, true, 0.25))
					group2:AddChild(UIF:ColorSelect("", db.Colors.NPC.NORMAL, "NEUTRAL", Callback, true, 0.25))
					group2:AddChild(UIF:ColorSelect("", db.Colors.NPC.NORMAL, "HOSTILE", Callback, true, 0.25))
					
					local group2 = UIF:InlineGroup2("Players")
					group:AddChild(group2)
					group2:AddChild(UIF:CheckBox("Color hostile by class", db.Colors.PLAYER, "UseHostileClassColor", Callback, "Only works in PvP-zones and with the 'Class Colors in Nameplates' option turned on in the Blizzard Interface options"))
					group2:AddChild(UIF:Text1(" ", nil, nil, nil, nil, nil, 0.25))
					group2:AddChild(UIF:Text1("Friedly", nil, nil, nil, nil, nil, 0.25))					
					group2:AddChild(UIF:Text1("Hostile", nil, nil, nil, nil, nil, 0.25))
					group2:AddChild(UIF:Text1(" ", nil, nil, nil, nil, nil, 0.25))
					group2:AddChild(UIF:Text1("Normal", nil, nil, nil, nil, nil, 0.25))
					group2:AddChild(UIF:ColorSelect("", db.Colors.PLAYER.NORMAL, "FRIENDLY", Callback, true, 0.25))					
					group2:AddChild(UIF:ColorSelect("", db.Colors.PLAYER.NORMAL, "HOSTILE", Callback, true, 0.25))
					group2:AddChild(UIF:Text1(" ", nil, nil, nil, nil, nil, 0.25))
					
					g:AddChild(UIF:LSMDropdown("statusbar", "Texture", db, "Texture", Callback, 0.5))
					
					return g
				end
			},
		}
		return options
	end
end
