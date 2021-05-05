local mNameplates = LibStub("AceAddon-3.0"):GetAddon("mNameplates")
if not mNameplates then return end
local plugin = mNameplates:NewModule("EliteIcon")
if not plugin then return end

plugin.DisplayName = "Elit Icon"
plugin.DisplayIcon = [[Interface\PvPRankBadges\PvPRank14]]

local AceGUI 	= LibStub("AceGUI-3.0")
local LSM		= LibStub("LibSharedMedia-3.0")
local Nameplates = LibStub("LibNameplate-1.0")
local UIF
local db

local Cache = {}

local TextureMappning = {
	["Alliance"] = [[Interface\PvPRankBadges\PvPRankAlliance]],
	["Horde"] = [[Interface\PvPRankBadges\PvPRankHorde]],
	["Rank 15"] = [[Interface\PvPRankBadges\PvPRank15]],
	["Rank 14"] = [[Interface\PvPRankBadges\PvPRank14]],
	["Rank 13"] = [[Interface\PvPRankBadges\PvPRank13]],
	["Rank 12"] = [[Interface\PvPRankBadges\PvPRank12]],
	["Rank 11"] = [[Interface\PvPRankBadges\PvPRank11]],
	["Rank 10"] = [[Interface\PvPRankBadges\PvPRank10]],
	["Rank 09"] = [[Interface\PvPRankBadges\PvPRank09]],
	["Rank 08"] = [[Interface\PvPRankBadges\PvPRank08]],
	["Rank 07"] = [[Interface\PvPRankBadges\PvPRank07]],
	["Rank 06"] = [[Interface\PvPRankBadges\PvPRank06]],
	["Rank 05"] = [[Interface\PvPRankBadges\PvPRank05]],
	["Rank 04"] = [[Interface\PvPRankBadges\PvPRank04]],
	["Rank 03"] = [[Interface\PvPRankBadges\PvPRank03]],
	["Rank 02"] = [[Interface\PvPRankBadges\PvPRank02]],
	["Rank 01"] = [[Interface\PvPRankBadges\PvPRank01]],
	
}

local defaults = {
	profile = {
		Enabled = true,
		
		Attached = {
			["**"] = {
				x = 0,
				y = -2,
				Point = "BOTTOMLEFT",
				RelPoint = "TOPLEFT",
			}
		},
		AttachedFrame = "NAMEPLATE",
		
		Texture = "Rank 15",
		
		Size = 20,
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
		data.EliteIcon:ClearAllPoints()
		data.EliteIcon:SetWidth(0)
		data.EliteIcon:SetHeight(0)
		data.EliteIcon:Hide()
		tinsert(Cache, data.EliteIcon)
		data.EliteIcon = nil
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
	local EliteIcon = table.remove(Cache)
	if not EliteIcon then
		EliteIcon = CreateFrame("Frame", nil, data.Background)
		EliteIcon:SetFrameLevel(plate:GetFrameLevel() + mNameplates.Levels.Icon)
		local t = EliteIcon:CreateTexture(nil, "ARTOWRK")
		t:SetAllPoints()		
		EliteIcon.Texture = t
		EliteIcon:Hide()
	end
	EliteIcon:SetParent(data.Background)
	data.EliteIcon = EliteIcon
end

function plugin:PlateShow(event, plate, data)		
	self:ApplyOnPlate(plate, data)
end

function plugin:PlateHide(event, plate, data)
	data.EliteIcon:Hide()
end

-- ~~~~~~~~~~~~~~~~~~~~~~
-- Events ~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~

-- ~~~~~~~~~~~~~~~~~~~~~~
-- Settings ~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~
function plugin:ApplyOnPlate(plate, data)
	local frame = mNameplates:GetAttachFrame(db.AttachedFrame, plate) or plate
	data.EliteIcon:ClearAllPoints()
	data.EliteIcon:SetPoint(db.Attached[db.AttachedFrame].Point, frame, db.Attached[db.AttachedFrame].RelPoint, db.Attached[db.AttachedFrame].x, db.Attached[db.AttachedFrame].y)			
	
	if Nameplates:IsElite(plate) and not Nameplates:IsBoss(plate) then		
		data.EliteIcon:SetAlpha(db.Alpha)
		data.EliteIcon:SetWidth(db.Size)
		data.EliteIcon:SetHeight(db.Size)
		
		data.EliteIcon.Texture:SetTexture(TextureMappning[db.Texture])		
		
		data.EliteIcon:Show()
	else
		data.EliteIcon:SetWidth(0.1)
		data.EliteIcon:SetHeight(0.1)
		data.EliteIcon:Hide()
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
	return data.EliteIcon
end

-- ~~~~~~~~~~~~~~~~~~~~~~
-- Options ~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~
do
	local function Callback()
		plugin:ApplyAllPlates()
	end
	
	local TextureList = {
		["Alliance"] = {text = "Alliance", value = "Alliance", icon =  TextureMappning["Alliance"]},
		["Horde"] = {text = "Horde", value = "Horde", icon = TextureMappning["Horde"]},
		["Rank 15"] = {text = "Rank 15", value = "Rank 15", icon = TextureMappning["Rank 15"]},
		["Rank 14"] = {text = "Rank 14", value = "Rank 14", icon = TextureMappning["Rank 14"]},
		["Rank 13"] = {text = "Rank 13", value = "Rank 13", icon = TextureMappning["Rank 13"]},
		["Rank 12"] = {text = "Rank 12", value = "Rank 12", icon = TextureMappning["Rank 12"]},
		["Rank 11"] = {text = "Rank 11", value = "Rank 11", icon = TextureMappning["Rank 11"]},
		["Rank 10"] = {text = "Rank 10", value = "Rank 10", icon = TextureMappning["Rank 10"]},
		["Rank 09"] = {text = "Rank 9", value = "Rank 09", icon = TextureMappning["Rank 09"]},
		["Rank 08"] = {text = "Rank 8", value = "Rank 08", icon = TextureMappning["Rank 08"]},
		["Rank 07"] = {text = "Rank 7", value = "Rank 07", icon = TextureMappning["Rank 07"]},
		["Rank 06"] = {text = "Rank 6", value = "Rank 06", icon = TextureMappning["Rank 06"]},
		["Rank 05"] = {text = "Rank 5", value = "Rank 05", icon = TextureMappning["Rank 05"]},
		["Rank 04"] = {text = "Rank 4", value = "Rank 04", icon = TextureMappning["Rank 04"]},
		["Rank 03"] = {text = "Rank 3", value = "Rank 03", icon = TextureMappning["Rank 03"]},
		["Rank 02"] = {text = "Rank 2", value = "Rank 02", icon = TextureMappning["Rank 02"]},
		["Rank 01"] = {text = "Rank 1", value = "Rank 01", icon = TextureMappning["Rank 01"]},
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
					
					local group = UIF:InlineGroup(" ")
					g:AddChild(group)
					group:AddChild(UIF:Slider("Size", db, "Size", 1, 100, 0.1, Callback, 0.5))
					group:AddChild(UIF:Slider("Alpha", db, "Alpha", 0, 1, 0.01, Callback, 0.5))
					
					g:AddChild(UIF:Dropdown("Texture", db, "Texture", Callback, TextureList, 0.5))
					
					return g
				end
			}
		}
		return options
	end
end