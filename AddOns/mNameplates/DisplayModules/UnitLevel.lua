local mNameplates = LibStub("AceAddon-3.0"):GetAddon("mNameplates")
if not mNameplates then return end
local plugin = mNameplates:NewModule("UnitLevel")
if not plugin then return end

plugin.DisplayName = "Level"
plugin.DisplayIcon = [[Interface\Icons\achievement_level_80]]

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
				y = 1,
				Point = "LEFT",
				RelPoint = "LEFT",
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
		data.LevelFrame:ClearAllPoints()
		data.LevelFrame:Hide()
		tinsert(Cache, data.LevelFrame)
		data.LevelFrame = nil
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
	local textFrame = table.remove(Cache)
	if not textFrame then
		textFrame = CreateFrame("Frame", nil, data.Background)	
		textFrame:SetFrameLevel(plate:GetFrameLevel() + mNameplates.Levels.Text)
		textFrame:SetWidth(1)
		textFrame:SetHeight(1)
		local text = textFrame:CreateFontString(nil, nil, "GameFontNormal")
		text:SetPoint("LEFT")
		textFrame.txt = text
	end
	textFrame:SetParent(data.Background)
	data.LevelFrame = textFrame
end

function plugin:PlateShow(event, plate, data)				
	local level = Nameplates:IsBoss(plate) and (UnitLevel("player") + 3) or Nameplates:GetLevel(plate)
	data.LevelFrame.txt:SetText(level ..(Nameplates:IsBoss(plate) and "++" or Nameplates:IsElite(plate) and "+" or ""))
	data.LevelFrame:SetWidth(data.LevelFrame.txt:GetStringWidth())
	data.LevelFrame:SetHeight(data.LevelFrame.txt:GetStringHeight())
	self:ApplyOnPlate(plate)
end

function plugin:PlateHide(event, plate, data)
	data.LevelFrame:Hide()
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
	data.LevelFrame:ClearAllPoints()
	data.LevelFrame:SetPoint(db.Attached[db.AttachedFrame].Point, frame, db.Attached[db.AttachedFrame].RelPoint, db.Attached[db.AttachedFrame].x, db.Attached[db.AttachedFrame].y)
	data.LevelFrame:Show()
	
	data.LevelFrame.txt:SetFont(LSM:Fetch("font", db.Font), db.FontSize, db.FontFlags)
	if db.FontShadow then
		data.LevelFrame.txt:SetShadowOffset(db.FontShadowX, db.FontShadowY)
		data.LevelFrame.txt:SetShadowColor(unpack(db.FontShadowColor))
	else
		data.LevelFrame.txt:SetShadowOffset(0, 0)
	end
	
	local level = Nameplates:IsBoss(plate) and (UnitLevel("player") + 3) or Nameplates:GetLevel(plate)
	local c = GetQuestDifficultyColor(level)
	data.LevelFrame.txt:SetTextColor(c.r, c.g, c.b)
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
	return data.LevelFrame
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
				data = {{text = "Modules", value = "Modules"}, {text="Level", value = "UnitLevel"}},
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