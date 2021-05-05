mNameplates = LibStub("AceAddon-3.0"):NewAddon("mNameplates", "AceEvent-3.0", "AceConsole-3.0", "AceHook-3.0")
local mNameplates = mNameplates
MDB_MN = mNameplates

mNameplates.DisplayIcon = [[Interface\Icons\inv_shield_09]]

local UIF
local LSM = LibStub("LibSharedMedia-3.0")
local AceGUI = LibStub("AceGUI-3.0")
local Nameplates = LibStub("LibNameplate-1.0")

LSM:Register("font", "accid", [[Interface\AddOns\mRunes\accid.ttf]])
LSM:Register("statusbar", "HalD", [[Interface\AddOns\mRunes\HalD.tga]])

local db

local Cache = {}

local bossIconTexture = [[Interface\TargetingFrame\UI-TargetingFrame-Skull]]

local ResetTextures = {
	ThreatGlow = [[Interface\TargetingFrame\UI-TargetingFrame-Flash]],
	Highlight = [[Interface\Tooltips\Nameplate-Glow]],
	BossIcon = [[Interface\TargetingFrame\UI-TargetingFrame-Skull]],
	ElitIcon = [[Interface\Tooltips\EliteNameplateIcon]],
	CastBorder = [[Interface\Tooltips\Nameplate-Border]],
	RaidIcon = [[nterface\TargetingFrame\UI-RaidTargetingIcons]],
}

local DefaultWidth, DefaultHeight, DefaultIconSize
local InCombat = false

-- Combat Wrappers
local StateScriptSet = {}
local ApplyPlateSet = {}
local PlateReset = {}

mNameplates.Levels = {
	Bars = 2,
	Text = 3,
	Icon = 4,
}

local StateHeader = CreateFrame("Frame", nil, nil, "SecureHandlerBaseTemplate")
StateHeader:RegisterEvent("PLAYER_REGEN_ENABLED")
StateHeader:SetScript("OnEvent", function(self, event, ...)
	for plate in pairs(PlateReset) do
		mNameplates:ResetLockedAttributes(plate)
	end
	wipe(PlateReset)
end)

function mNameplates:OnInitialize()
	local defaults = {
		profile = {
			Enabled = true,
			
			Width = 125,
			Height = 25,
		}
	}
	
	self.db  = LibStub("AceDB-3.0"):New("mNameplatesDB", defaults, "Default")
	db = self.db.profile
	
	self.db.RegisterCallback(self, "OnProfileChanged", "ProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "ProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "ProfileChanged")
	
	self:SetupLDB()
	
	self:SetEnabledState(db.Enabled)
	
	self.Callbacks = LibStub("CallbackHandler-1.0"):New(self)	
	
	self.Plates = {}

	UIF = LibStub("LibGUIFactory-1.0"):GetFactory("mNameplates", {font = LibStub("LibSharedMedia-3.0"):Fetch("font", "accid"), fontSize = 16})
	UIF:SetValuesChangedCallback(function() 
		mNameplates:ToggleConfig(true)
	end)
	
	self:RegisterChatCommand("mn", "ToggleConfig")
end

function mNameplates:OnEnable()
	if UnitAffectingCombat("plater") then InCombat = true end	
	
	Nameplates.RegisterCallback(self, "LibNameplate_FoundGUID")
	Nameplates.RegisterCallback(self, "LibNameplate_NewNameplate")
	Nameplates.RegisterCallback(self, "LibNameplate_MouseoverNameplate")
	Nameplates.RegisterCallback(self, "LibNameplate_HealthChange")	
	Nameplates.RegisterCallback(self, "LibNameplate_RecycleNameplate")
	
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	
	for i, plate in pairs({select(2, Nameplates:GetAllNameplates())}) do
		self:LibNameplate_NewNameplate("LibNameplate_NewNameplate", plate)
	end
	
	wipe(PlateReset)
end

function mNameplates:OnDisable()
	for moduleName, module in self:IterateModules() do
		LibStub("AceAddon-3.0"):DisableAddon(module)
	end
	for	i, plate in pairs(self.Plates) do
		plate.DefaultItems.ThreatGlow:SetTexture(ResetTextures.ThreatGlow)
		plate.DefaultItems.Highlight:SetTexture(ResetTextures.Highlight)
		plate.DefaultItems.BossIcon:SetTexture(ResetTextures.BossIcon)
		plate.DefaultItems.ElitIcon:SetTexture(ResetTextures.ElitIcon)
		plate.DefaultItems.CastBorder:SetTexture(ResetTextures.CastBorder)
		plate.DefaultItems.RaidIcon:SetTexture(ResetTextures.RaidIcon)
		print(DefaultIconSize)
		plate.DefaultItems.Icon:SetHeight(DefaultIconSize)
		plate.DefaultItems.Icon:SetWidth(DefaultIconSize)
		
		plate.DefaultItems.Name:Show()
		plate.DefaultItems.HealthBorder:Show()
		plate.DefaultItems.Level:Show()
		plate.DefaultItems.HealthBar:Show()
		plate.DefaultItems.CastBar:Show()
		
		self:Unhook(plate.DefaultItems.CastBar, "OnShow")
		
		
		local data = mNameplates:GetExtra(plate)
		data.Background:ClearAllPoints()
		data.Background:Hide()
		tinsert(Cache, data.Background)
		data.Background = nil		
		
		plate.DefaultItems = nil
		plate.mn = nil
		
		self:CombatWrapperResetPlate(plate)
	end
	wipe(self.Plates)
	
	Nameplates.UnregisterAllCallbacks(self)
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Callbacks ~~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~
function mNameplates:LibNameplate_NewNameplate(event, plate)
	self:PrepPlate(plate)
	plate.DefaultItems.Level:Hide()
	
	local filtered = false
	for i, filter in pairs(self.Filters) do
		local result = filter:RunFilter(plate)
		if result then filtered = result end
	end
	
	local data = mNameplates:GetExtra(plate)
	if not filtered then		
		data.Background:SetParent(plate)
		data.Background:Show()
		data.Background.Background:Show()
		self:ApplyOnPlate(plate, data)
		
		self.Callbacks:Fire("PlateShow", plate, data)
	else
		data.Background:SetParent(plate)
		data.Background:Show()
		data.Background.Background:Hide()
		self:ApplyOnPlate(plate, data)
		
		self.Callbacks:Fire("PlateShowFiltered", plate, data)
	end
end

function mNameplates:LibNameplate_FoundGUID(event, plate, gUID, unit)
	local data = self:GetExtra(plate)
	if data then 
		self.Callbacks:Fire("PlateGUID", gUID, unit, self:GetExtra(plate))
	end
end

function mNameplates:LibNameplate_MouseoverNameplate(event, plate)
	if self.CurrentMouseOver and self.CurrentMouseOver == plate then return end
	self:MouseOverUpdate()
	self.CurrentMouseOver = plate
	local data = mNameplates:GetExtra(plate)
	self.Callbacks:Fire("PlateMouseover", plate, data)	
	self:RegisterOnUpdate(self, self.MouseOverUpdate)	
	if data then
		for i, frame in pairs(data) do 
			frame:SetFrameLevel(frame:GetFrameLevel() + 100)
		end
	end
end

function mNameplates:LibNameplate_HealthChange(event, plate)
	local data = self:GetExtra(plate)
	if data then
		self.Callbacks:Fire("PlateHPChanged", plate, data)
	end
end

function mNameplates:LibNameplate_RecycleNameplate(event, plate)
	local data = self:GetExtra(plate)
	if data then
		self.Callbacks:Fire("PlateHide", plate, data)
	end
end

function mNameplates:ProfileChanged(event)
	db = self.db.profile
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Events ~~~~~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~
function mNameplates:UPDATE_MOUSEOVER_UNIT(...)	
	local plate = Nameplates:GetNameplateByUnit("mouseover")
	if self.CurrentMouseOver and self.CurrentMouseOver == plate then return end
	if plate then
		self:MouseOverUpdate()
		self.CurrentMouseOver = plate
		local data = mNameplates:GetExtra(plate)
		self.Callbacks:Fire("PlateMouseover", plate, data)	
		self:RegisterOnUpdate(self, self.MouseOverUpdate)			
		if data then
			for i, frame in pairs(data) do 
				frame:SetFrameLevel(frame:GetFrameLevel() + 100)
			end
		end
	end
end

function mNameplates:PLAYER_REGEN_DISABLED()
	InCombat = true
end

function mNameplates:PLAYER_REGEN_ENABLED()
	InCombat = false
	for plate in pairs(StateScriptSet) do		
		self:SetStateScript(plate)
	end
	for plate in pairs(ApplyPlateSet) do
		self:SetLockedAttributes(plate)
	end
	
	
	wipe(StateScriptSet)
	wipe(ApplyPlateSet)
	wipe(PlateReset)
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Creation ~~~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~
do
	local function CastBarShow(self)
		self:Hide()
		local plate = self:GetParent()
		plate.DefaultItems.Icon:SetTexture(nil)
	end

	local regions = {}
	function mNameplates:PrepPlate(plate)	
		if plate.mn then return end
		local healthBar, castBar = plate:GetChildren()
		local threatGlow, healthBorder, castbarBorder, castNoInterupt, castIcon, highlight, name, level, bossIcon, raidIcon, eliteIcon = plate:GetRegions()		
		healthBar:Hide()
		castBar:Hide()
		
		self:HookScript(castBar, "OnShow", CastBarShow)
		DefaultIconSize = DefaultIconSize or castIcon:GetHeight()
		
		threatGlow:SetTexture(nil)
		highlight:SetTexture(nil)
		bossIcon:SetTexture(nil)
		eliteIcon:SetTexture(nil)
		castbarBorder:SetTexture(nil)
		castNoInterupt:SetTexture(nil)		
		raidIcon:SetTexture(nil)
		castIcon:SetWidth(0.01)
		castIcon:SetHeight(0.01)
		
		name:Hide()		
		healthBorder:Hide()
		
		plate.mn = {}
		
		plate.DefaultItems = {
			HealthBar = healthBar,
			CastBar = castBar,
			ThreatGlow = threatGlow,
			HealthBorder = healthBorder,
			CastBorder = castbarBorder,
			CastNoInterupt = castNoInterupt,
			Icon = castIcon,
			Highlight = highlight,
			Name = name,
			Level = level,
			BossIcon = bossIcon,
			RaidIcon = raidIcon,
			ElitIcon = eliteIcon,
		}

		tinsert(self.Plates, plate)					
		
		DefaultHeight = DefaultHeight or plate:GetHeight()
		DefaultWidth = DefaultWidth or plate:GetWidth()			
		self:CombatWrapperSetStateScript(plate)
		
		local Background = tremove(Cache)
		if not Background then
			Background = CreateFrame("Frame", nil, plate)			
			Background:SetFrameLevel(plate:GetFrameLevel())
			Background:SetPoint("CENTER")
		
			local t = Background:CreateTexture()
			t:SetAllPoints()
			t:SetTexture(0, 0, 0, 0.5)
			Background.Background = t
		end		
		Background:ClearAllPoints()
		Background:SetParent(plate)
		Background:SetPoint("CENTER")		
		plate.mn.Background = Background
		
		self.Callbacks:Fire("PlateNew", plate, self:GetExtra(plate))
	end
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Settings ~~~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~
function mNameplates:ApplyOnPlate(plate, data)
	self:CombatWrapperApplyPlate(plate)
	self:CombatWrapperSetStateScript(plate)
	data.Background:SetWidth(db.Width)
	data.Background:SetHeight(db.Height)
end

function mNameplates:Applyettings()
	for i, plate in self:IteratePlates() do
		self:ApplyOnPlate(plate, self:GetExtra(plate))
	end
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Misc ~~~~~~~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~
function mNameplates:IteratePlates()
	return pairs(self.Plates)
end

function mNameplates:GetExtra(plate)
	assert(plate, "No plates passed to get extra")
	return plate.mn
end

do 
	local AttachList = {}
	local AnchorList = {}
	function mNameplates:GetAttachList(callingModule)
		wipe(AttachList)
		for moduleName, module in self:IterateModules() do
			if module ~= callingModule then
				AttachList[moduleName] = {text = module.DisplayName or moduleName, value = moduleName, disabled = (not module:IsEnabled()) or (callingModule:GetName() == module.db.profile.AttachedFrame), icon = module.DisplayIcon}
			end
		end
		AttachList["NAMEPLATE"] = {text = "Nameplate", value = "NAMEPLATE", icon = [[Interface\Icons\inv_shield_09]]}
		
		return AttachList
	end
	
	function mNameplates:GetAttachFrame(moduleName, plate)
		local module = self:GetModule(moduleName, "true")
		if module then
			return module:GetAttachFrame(plate)
		end
	end
	
	function mNameplates:GetAnchorList()		
		AnchorList = AnchorList or {}
		AnchorList["TOPLEFT"] = "Top left"
		AnchorList["TOP"] = "Top"
		AnchorList["TOPRIGHT"] = "Top Right"
		AnchorList["RIGHT"] = "Right"
		AnchorList["BOTTOMRIGHT"] = "Bottom right"
		AnchorList["BOTTOM"] = "Bottom"
		AnchorList["BOTTOMLEFT"] = "Bottom left"
		AnchorList["LEFT"] = "Left"
		AnchorList["CENTER"] = "Center"
		
		return AnchorList
	end
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Combat Wrappers ~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~

function  mNameplates:CombatWrapperSetStateScript(plate)
	if InCombat then
		StateScriptSet[plate] = true
	else
		self:SetStateScript(plate)
	end
end

function mNameplates:CombatWrapperApplyPlate(plate)
	if InCombat then
		ApplyPlateSet[plate] = true
	else
		self:SetLockedAttributes(plate)
	end
end

function mNameplates:CombatWrapperResetPlate(plate)
	if InCombat then
		PlateReset[plate] = true
	else
		self:ResetLockedAttributes(plate)
	end
end

function mNameplates:SetStateScript(plate)
	StateHeader:UnwrapScript(plate, "OnShow")
	StateHeader:WrapScript(plate, "OnShow", [[
		self:SetWidth(]]..db.Width..[[)
		self:SetHeight(]]..db.Height..[[)
	]])
end

function mNameplates:SetLockedAttributes(plate)
	plate:SetWidth(db.Width)
	plate:SetHeight(db.Height)
end

function mNameplates:ResetLockedAttributes(plate)
	plate:SetWidth(DefaultWidth)
	plate:SetHeight(DefaultHeight)
	StateHeader:UnwrapScript(plate, "OnShow")
end

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Config ~~~~~~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~
do	
	local function Callback()
		mNameplates:Applyettings()
	end

	local OptionsFrame
	local SelectedOption
	local OptionsStatus = {}
	
	function mNameplates:ToggleConfig(reOpen)
		if not OptionsFrame then	
			OptionsFrame = UIF:Frame("mNameplates")
			OptionsFrame:SetLayout("Fill")
			OptionsFrame:SetWidth(813)
			OptionsFrame:SetHeight(630)
			OptionsFrame:Hide()			
			OptionsFrame:SetCallback("OnClose", function(widget)				
				OptionsFrame:ReleaseChildren()		
				OptionsFrame.frame:Hide()
			end)			
		end
		
		if OptionsFrame.frame:IsShown() then
			OptionsFrame:Hide()
			if not reOpen then
				return
			end
		end
		
		m = UIF:TreeGroup()
		m:SetLayout("Fill")	
		m:SetCallback("OnGroupSelected", function(self, event, group) SelectedOption = group end)									
		OptionsFrame:AddChild(m)
		
		m:AddGroup({{text = "Main", value = "Main", order = 0}}, function()
			local g = UIF:InlineGroup1()
			
			g:AddChild(UIF:CheckBox("Enabled", db, "Enabled", function() 
				if db.Enabled and not mNameplates:IsEnabled() then mNameplates:Enable()
				elseif not db.Enabled and mNameplates:IsEnabled() then mNameplates:Disable() end
			end))
			
			g:AddChild(UIF:Slider("Width", db, "Width", 0, 300, 0.1, Callback, 0.5))
			g:AddChild(UIF:Slider("Height", db, "Height", 0, 300, 0.1, Callback, 0.5))
			
			return g
		end, self.DisplayIcon)
	
		for moduleName, module in self:IterateModules() do
			if module.GetOptions then
				local options = module:GetOptions()
				if options and type(options) == "table" then
					for i, option in pairs(options) do
						m:AddGroup(option.data, option.func, option.icon)
					end
				end
			end
		end
		
		m:AddGroup({{text = "Profile", value = "Profile"}}, function()
			return UIF:AceProfileOption(mNameplates.db)
		end)
		
		m:SetSelected(SelectedOption or "Main")
		m:SetStatusTable(OptionsStatus)	
		OptionsFrame:Show()
	end

	function mNameplates:SetupLDB()
		local LDB = LibStub("LibDataBroker-1.1")
		if not LDB then return end
		
		local l = LDB:NewDataObject("mNameplates")
		l.type = "launcher"
		l.icon = [[Interface\Icons\Spell_DeathKnight_RuneTap]]
		l.tocname = "mNameplates"
		l.label = "mNameplates"
		l.OnClick = function(self, button)
			mNameplates:ToggleConfig()
		end
		l.OnTooltipShow = function(tt)
			tt:AddLine("mNameplates")
			tt:AddLine("Click to toggle configuration")
		end
		
		self.ldbojb = l
	end
end