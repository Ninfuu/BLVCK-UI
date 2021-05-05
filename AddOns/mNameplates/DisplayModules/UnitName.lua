local mNameplates = LibStub("AceAddon-3.0"):GetAddon("mNameplates")
if not mNameplates then return end
local plugin = mNameplates:NewModule("UnitName")
if not plugin then return end

plugin.DisplayName = "Name"
plugin.DisplayIcon = [[Interface\Icons\spell_arcane_arcanepotency]]

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
				y = 2,
				Point = "BOTTOM",
				RelPoint = "TOP",
			}
		},
		AttachedFrame = "HealthBars",
		
		Font = "accid",
		FontSize = 10,
		FontFlags = "OUTLINE",
		FontColor = {157/255, 24/255, 68/255, 1},
		FontShadow = true,
		FontShadowX = 1,
		FontShadowY = -1,
		FontShadowColor = {0, 0, 0, 1},
		
		Colors = {
			["**"] = {
				["**"] = {
					FRIENDLY = {1, 1, 1, 1},
					NEUTRAL = {1, 1, 1, 1},
					HOSTILE = {1, 1, 1, 1},
				}
			},
			PLAYER = {
				UseHostileClassColor = true,
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
	mNameplates.RegisterCallback(self, "PlateShowFiltered")
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
		data.NameFrame:ClearAllPoints()
		data.NameFrame:Hide()
		tinsert(Cache, data.NameFrame)
		data.NameFrame = nil
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
	local textFrame = table.remove(Cache)
	if not textFrame then
		textFrame = CreateFrame("Frame", nil, data.Background)	
		textFrame:SetWidth(1)
		textFrame:SetHeight(1)
		local text = textFrame:CreateFontString(nil, nil, "GameFontNormal")
		text:SetPoint("CENTER")
		textFrame.txt = text
	end
	textFrame:SetParent(data.Background)
	data.NameFrame = textFrame
end

function plugin:PlateShow(event, plate, data)
	self:ApplyOnPlate(plate)
	local name = Nameplates:GetName(plate)
	data.NameFrame.txt:SetText(name)
	data.NameFrame:SetWidth(data.NameFrame.txt:GetStringWidth())
	data.NameFrame:SetHeight(data.NameFrame.txt:GetStringHeight())
end

function plugin:PlateShowFiltered(event, plate, data)
	self:ApplyOnPlate(plate)
	data.NameFrame:ClearAllPoints()
	data.NameFrame:SetPoint("TOP", data.Background, "TOP")
	local name = Nameplates:GetName(plate)
	data.NameFrame.txt:SetText(name)
	data.NameFrame:SetWidth(data.NameFrame.txt:GetStringWidth())
	data.NameFrame:SetHeight(data.NameFrame.txt:GetStringHeight())
end

function plugin:PlateHide(event, plate, data)
	data.NameFrame:Hide()
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
	data.NameFrame:ClearAllPoints()
	data.NameFrame:SetPoint(db.Attached[db.AttachedFrame].Point, frame, db.Attached[db.AttachedFrame].RelPoint, db.Attached[db.AttachedFrame].x, db.Attached[db.AttachedFrame].y)
	data.NameFrame:Show()
	
	data.NameFrame.txt:SetFont(LSM:Fetch("font", db.Font), db.FontSize, db.FontFlags)
	data.NameFrame.txt:SetTextColor(unpack(db.FontColor))
	if db.FontShadow then
		data.NameFrame.txt:SetShadowOffset(db.FontShadowX, db.FontShadowY)
		data.NameFrame.txt:SetShadowColor(unpack(db.FontShadowColor))
	else
		data.NameFrame.txt:SetShadowOffset(0, 0)
	end
	
	local unitType = Nameplates:GetType(plate)
	local reaction = Nameplates:GetReaction(plate)
	if reaction and unitType then
		if unitType == "NPC" then
			if Nameplates:IsBoss(plate) then
				data.NameFrame.txt:SetTextColor(unpack(db.Colors.NPC.BOSS[reaction]))
			elseif Nameplates:IsElite(plate) then
				data.NameFrame.txt:SetTextColor(unpack(db.Colors.NPC.ELITE[reaction]))
			else
				data.NameFrame.txt:SetTextColor(unpack(db.Colors.NPC.NORMAL[reaction]))
			end
		else			
			if (reaction == "HOSTILE" and db.Colors.PLAYER.UseHostileClassColor) then								
				local class = Nameplates:GetClass(plate)
				if class then
					local c = RAID_CLASS_COLORS[class]
					data.NameFrame.txt:SetTextColor(c.r, c.g, c.b)
				else
					data.NameFrame.txt:SetTextColor(unpack(db.Colors.PLAYER.NORMAL[reaction]))
				end
			else
				data.NameFrame.txt:SetTextColor(unpack(db.Colors.PLAYER.NORMAL[reaction]))
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
	return data.NameFrame
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
				data = {{text = "Modules", value = "Modules"}, {text="Name", value = "UnitName"}},
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
					
					return g
				end
			}
		}
		return options
	end
end