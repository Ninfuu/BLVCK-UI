local mNameplates = LibStub("AceAddon-3.0"):GetAddon("mNameplates")
if not mNameplates then return end
local plugin = mNameplates:NewModule("UnitGuild", "AceEvent-3.0")
if not plugin then return end

plugin.DisplayName = "Guild"
plugin.DisplayIcon = [[Interface\GuildBankFrame\UI-GuildBankFrame-NewTab]]

local AceGUI 	= LibStub("AceGUI-3.0")
local LSM		= LibStub("LibSharedMedia-3.0")
local Nameplates = LibStub("LibNameplate-1.0")
local UIF
local db

local Cache = {}

PlayerGuild = GetGuildInfo("player")

local defaults = {
	profile = {
		Enabled = false,
		
		Attached = {
			["**"] = {
				x = 0,
				y = 0,
				Point = "CENTER",
				RelPoint = "CENTER",
			}
		},
		AttachedFrame = "NAMEPLATE",
		
		GuildCache = {},
		SaveCache = true,
		
		Font = "accid",
		FontSize = 12,
		FontFlags = "OUTLINE",
		FontColor = {113/255, 255/255, 186/255, 1},
		FontColorSameGuild = {236/255, 0/255, 255/255, 1},
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
	
	if not db.SaveCache then db.GuildCache = {} end
	
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
	
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	
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
		data.Guild:SetWidth(0.1)
		data.Guild:SetHeight(0.1)
		tinsert(Cache, data.Guild)
		data.Guild = nil
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
	local Guild = table.remove(Cache)
	if not Guild then
		Guild = CreateFrame("Frame", nil, data.Background)
		Guild:SetFrameLevel(plate:GetFrameLevel() + mNameplates.Levels.Text)
		local text = Guild:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		text:SetAllPoints()
		Guild.text = text
		Guild:Hide()
	end
	Guild:SetParent(data.Background)
	data.Guild = Guild
end

function plugin:PlateShow(event, plate, data)
	self:ApplyOnPlate(plate, data)
end

function plugin:PlateShowFiltered(event, plate, data)
	self:ApplyOnPlate(plate, data)
	data.Guild:ClearAllPoints()
	data.Guild:SetPoint("BOTTOM", data.Background, "BOTTOM")
end

function plugin:PlateHide(event, plate, data)
	data.Guild:Hide()
end


-- ~~~~~~~~~~~~~~~~~~~~~~
-- Events ~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~
function plugin:UPDATE_MOUSEOVER_UNIT()
	guild = GetGuildInfo("mouseover")	
	name, realm = UnitName("mouseover")
	if guild and name and not realm then		
		db.GuildCache[name] = guild
		local plate = Nameplates:GetNameplateByName(name)
		if plate then
			self:ApplyOnPlate(plate, mNameplates:GetExtra(plate))
		end
	end
end

-- ~~~~~~~~~~~~~~~~~~~~~~
-- Settings ~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~
function plugin:ApplyOnPlate(plate, data)	
	local frame = mNameplates:GetAttachFrame(db.AttachedFrame, plate) or plate
	data.Guild:ClearAllPoints()
	data.Guild:SetPoint(db.Attached[db.AttachedFrame].Point, frame, db.Attached[db.AttachedFrame].RelPoint, db.Attached[db.AttachedFrame].x, db.Attached[db.AttachedFrame].y)			
	
	local name = Nameplates:GetName(plate)
	local guild = db.GuildCache[name]
	
	if guild then
		data.Guild.text:SetText(guild)
		data.Guild:SetWidth(data.Guild.text:GetStringWidth())
		data.Guild:SetHeight(data.Guild.text:GetStringHeight())
		
		data.Guild.text:SetFont(LSM:Fetch("font", db.Font), db.FontSize, db.FontFlags)
		if guild == PlayerGuild then
			data.Guild.text:SetTextColor(unpack(db.FontColorSameGuild))
		else
			data.Guild.text:SetTextColor(unpack(db.FontColor))
		end
		if db.FontShadow then
			data.Guild.text:SetShadowOffset(db.FontShadowX, db.FontShadowY)
			data.Guild.text:SetShadowColor(unpack(db.FontShadowColor))
		else
			data.Guild.text:SetShadowOffset(0, 0)
		end
			
		data.Guild:Show()
	else
		data.Guild:SetWidth(0.1)
		data.Guild:SetHeight(0.1)
		data.Guild:Hide()
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
	return data.Guild
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
					end, nil, 0.3))
					g:AddChild(UIF:CheckBox("Store guild names between sessions", db, "SaveCache", nil, nil, 0.7))
					
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
					group:AddChild(UIF:ColorSelect("Color", db, "FontColor", Callback, true, 0.3))
					group:AddChild(UIF:ColorSelect("Color (Same Guild)", db, "FontColorSameGuild", Callback, true, 0.6))
									
					return g
				end
			}
		}
		return options
	end
end