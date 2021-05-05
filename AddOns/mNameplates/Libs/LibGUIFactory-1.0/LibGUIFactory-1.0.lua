local UIF_MAJOR, UIF_MINOR = "LibGUIFactory-1.0", 24
local UIF, oldminor = LibStub:NewLibrary(UIF_MAJOR, UIF_MINOR)
if not UIF then return end

local AceGUI = LibStub("AceGUI-3.0")
local LSM = LibStub("LibSharedMedia-3.0")

UIF.factories = UIF.factories or {}
UIF.embeds = {}

local InternalDrop, InternalButton

-- 

local function AddEmbed(name, func)
	UIF.embeds[name] = func
end

local function Embed(obj)
	for name, func in pairs(UIF.embeds) do
		obj[name] = func
	end
end

local function RecCheck(i, value, obj)
	if not obj then return end
	if type(value) == "table" then
		if (obj[i]) then
			assert(type(obj[i]) == "table", ("%q must be a table"):format(i))
			for subOpt, subValue in pairs(value) do
				RecCheck(subOpt, subValue, obj[i])
			end
		end		
	end
	if obj[i] then
		assert(type(obj[i]) == type(value), ("obj[%q] must be of type %s"):format(opt, type(value)))
	end
	obj[i] = obj[i] or value
end

local function ValidateAndInsertDefaults(obj)
	assert(obj and type(obj) == "table", "The provided object to be embeded with UIF-function must be a table")
	for opt, value in pairs(UIF.defaults) do
		if type(value) == "table" then
			if (obj[opt]) then
				assert(type(obj[opt]) == "table", ("[%q] must be a %s"):format(opt, type(value)))
				for subOpt, subValue in pairs(value) do
					RecCheck(subOpt, subValue, obj[subOpt])
				end
			end			
		end
		if obj[opt] then
			assert(type(obj[opt]) == type(value), ("obj[%q] must be of type %s"):format(opt, type(value)))
		end
		obj[opt] = obj[opt] or value
	end
	
	for opt, _ in pairs(obj) do
		assert(UIF.defaults[opt], ("The setting %q is not a vailid setting"):format(opt))
	end
end

function UIF:GetFactory(name, obj)
	assert(type(obj) == "table" or not obj, "Invalid factory object, it must be either nil or a table")
	
	if self.factories[name] then return self.factories[name] end
	
	newObj = {}
	newObj.s = obj
	newObj.name = name
	
	ValidateAndInsertDefaults(newObj.s)		
	
	Embed(newObj)
	
	self.factories[name] = newObj
	
	return newObj
end

function UIF:UpdateFactory(name, obj)
	assert(type(obj) == "table" or not obj, "Invalid factory object, it must be either nil or a table")
	assert(self.factories[name], ("The factory %s does not exist"):format(name))
	
	ValidateAndInsertDefaults(obj)
end

local function OnMouseEnter(widget, event)
	local title, text = widget:GetUserData("enterTitle"), widget:GetUserData("enterText")
	GameTooltip:SetOwner(widget.frame)
	if title then
		GameTooltip:AddLine(title)
	end
	GameTooltip:AddLine(text)
	GameTooltip:Show()
end

local function OnMouseLeave(wdiget, event)
	GameTooltip:Hide()
end

local function SetMouseOver(self, widget, title, text)
	widget:SetUserData("enterTitle", title)
	widget:SetUserData("enterText", text)
	widget:SetCallback("OnEnter", OnMouseEnter)
	widget:SetCallback("OnLeave", OnMouseLeave)
end
AddEmbed("SetMouseOver", SetMouseOver)


-- Internal
local function GetLabel(lType, self, text, color, size, font, flags, interactive, relativeWidth)
	if text then	assert(type(text) == "string" or type(text) == "number", ("%s-GuiFactory. %q must be a string or number"):format(self.name, "text")) end
	if color then 	assert(type(color) 	== "table" and color[1] and #color > 2 and 
		type(color[1]) == "number" and
		type(color[2]) == "number" and
		type(color[3]) == "number", ("%s-GuiFactory. %q must be a numeric indexed table with at least 3 values, each of numeric type"):format(self.name, "color")) end
	if size then 	assert(type(size) 	== "number", ("%s-GuiFactory. %q must be a number"):format(self.name, "size")) end
	if font then	assert(type(font) 	== "string", ("%s-GuiFactory. %q must be a string"):format(self.name, "font")) end
	if flags then 	assert(type(flags) 	== "string", ("%s-GuiFactory. %q must be a string"):format(self.name, "flags")) end
	
	local s = self.s[lType]
	
	color = color or s.fontColor or self.s.fontColor
	local label
	if interactive then
		label = AceGUI:Create("InteractiveLabel")
	else
		label = AceGUI:Create("UIF-Label")
	end
	
	label:SetImage([[Interface\Icons\Achievement_Dungeon_Ulduar77_25man]], 0, 1, 0, 1)
	label:SetImageSize(0, 0)
	label:SetImage(nil)
	label:SetFont(font or s.font or self.s.font, size or s.fontSize or self.s.fontSize, flags or s.fontFlags or self.s.fontFlags)
	label:SetColor(unpack(color))
	label:SetText(text)
	label:SetRelativeWidth(relativeWidth or 1)
	return label
end

--------------------
-- Labels

--- Create a TitleX object (Title1, Title2, Title3)
-- @paramsig [self ,] text [, color] [, size] [, font] [, flags] [, interactive]
-- @pram self Table that is the factory itself (optional when called with :Title1(..)
-- @param text Text to put in the label
-- @param color Table with 4 values 0.0-1.0 representing the RGB-value of the color
-- @param size Size of the font to use
-- @param font The fontfile to use
-- @param flags Font flags (THICKOUTLINE, OUTLINE, MONOCROME, NONE)
-- @interactive Boolean to tell if it should be an interactive text, meaning it triggers OnEnter and so on.
local function Title1(...)
	return GetLabel("Title1", ...)
end
local function Title2(...)
	return GetLabel("Title2", ...)
end
local function Title3(...)
	return GetLabel("Title3", ...)
end
AddEmbed("Title1", Title1)
AddEmbed("Title2", Title2)
AddEmbed("Title3", Title3)
AddEmbed("Title", Title1)
AddEmbed("MainTitleLabel", Title1)

local function Text1(...)
	return GetLabel("Text1", ...)
end
local function Text2(...)
	return GetLabel("Text2", ...)
end
local function Text3(...)
	return GetLabel("Text3", ...)
end
AddEmbed("Text1", Text1)
AddEmbed("Text2", Text2)
AddEmbed("Text3", Text3)
AddEmbed("NormalText", Text1)

--- Create a ListLevel1 object (ListLevel1, ListLevel2, ListLevel3)
-- @paramsig [self ,] text [, color] [, size] [, font] [, flags] [, interactive]
-- @pram self Table that is the factory itself (optional when called with :Title1(..)
-- @param text Text to put in the label
-- @param color Table with 4 values 0.0-1.0 representing the RGB-value of the color
-- @param size Size of the font to use
-- @param font The fontfile to use
-- @param flags Font flags (THICKOUTLINE, OUTLINE, MONOCROME, NONE)
-- @interactive Boolean to tell if it should be an interactive text, meaning it triggers OnEnter and so on.
local function ListLevel1(self, text, color, size, font, flags, interactive)
	return GetLabel("ListLevel1", self, text, color, size, font, flags, interactive)
end
local function ListLevel1(self, text, color, size, font, flags, interactive)
	return GetLabel("ListLevel2", self, text, color, size, font, flags, interactive)
end
local function ListLevel1(self, text, color, size, font, flags, interactive)
	return GetLabel("ListLevel3", self, text, color, size, font, flags, interactive)
end
AddEmbed("ListLevel1", ListLevel1)
AddEmbed("ListLevel3", ListLevel2)
AddEmbed("ListLevel2", ListLevel3)
AddEmbed("ListText", ListLevel1)

---------------------
-- Frame

-- Create a main window for your GUI
-- @paramsig [self, ] text
-- @param self Table that is the factory itself, should not be passed when used lik Factory:Frame(...)
-- @param text Text to put in the title area of the window
local function Frame(self, text)
	local s = self.s["Frame"]
	
	local group = AceGUI:Create("UIF-Frame")
	group:SetTitleFont(s.font or self.s.font, s.fontSize or self.s.fontSize, s.fontFlags or self.s.fontFlags)
	group:SetTitleFontColor(s.fontColor or self.s.fontColor)
	group:SetBorderColor(s.borderColor or self.s.borderColor)
	group:SetBackColor(s.bgColor or self.s.bgColor)
	group:SetTitle(text)
	
	local button = self:Button("")
	
	group:SetButton(button)
	
	return group
end
AddEmbed("Frame", Frame)

---------------------
-- Dropdown group

local function DropdownGroup(self, text)
	local s = self.s["DropdownGroup"]
	
	local group = AceGUI:Create("UIF-DropdownGroup")
	group:SetFullWidth(true)
	group:SetFont(s.font or self.s.font, s.fontSize or self.s.fontSize, s.fontFlags or self.s.fontFlags)
	group:SetFontColor(s.fontColor or self.s.fontColor)
	group:SetBorderColor(s.borderColor or self.s.borderColor)
	
	group:SetTitle(text)
	
	local drop = InternalDrop(self)
	group:SetDropdownWidget(drop)
	return group
end
AddEmbed("DropdownGroup", DropdownGroup)

----------------------
-- Tree group

local function TreeGroup(self)
	local s = self.s["TreeGroup"]
	
	local group = AceGUI:Create("UIF-TreeGroup")
	group:SetFullWidth(true)
	group:SetFont(s.font or self.s.font, s.fontSize or self.s.fontSize, s.fontFlags or self.s.fontFlags)
	group:SetFontColor(s.fontColor or self.s.fontColor)
	group:SetSubFont(s.subFont or self.s.font, s.subFontSize or self.s.fontSize, s.subFontFlags or self.s.fontFlags)
	group:SetSubColor(s.subColor or self.s.fontColor)
	group:SetBorderColor(s.borderColor or self.s.borderColor)
	return group
end
AddEmbed("TreeGroup", TreeGroup)

----------------------
-- Tab group

local function TGroup(tType, self, text)
	if text then	assert(type(text)	== "string", ("%s-GuiFactory. %q must be a string"):format(self.name, "text")) end
	
	local s = self.s[tType]
	
	local group = AceGUI:Create("UIF-TabGroup")	
	
	group:SetBorderColor(s.borderColor or self.s.borderColor)
	group:SetBackColor(s.bgColor)
	group:SetFont(s.font or self.s.font, s.fontSize or self.s.fontSize, s.fontFlags or self.s.fontFlags)
	group:SetFontColor(s.fontColor or self.s.fontColor)
	
	group:SetTitle(text)
	
	group:SetFullWidth(true)
	group:SetLayout("Flow")

	return group
end

local function TabGroup1(self, text)
	return TGroup("TabGroup1", self, text)
end
local function TabGroup2(self, text)
	return TGroup("TabGroup2", self, text)
end
local function TabGroup2(self, text)
	return TGroup("TabGroup3", self, text)
end
AddEmbed("TabGroup1", TabGroup1)
AddEmbed("TabGroup", TabGroup1) -- Backwards compability
AddEmbed("TabGroup2", TabGroup2)
AddEmbed("TabGroup3", TabGroup3)

----------------------
-- Inline group

local function IGroup(gType, self, text, bgColor, borderColor)
	if text then	assert(type(text)	== "string", ("%s-GuiFactory. %q must be a string"):format(self.name, "text")) end
	if bgColor then 	assert(type(bgColor) 	== "table" and #bgColor > 2 and 
		type(bgColor[1]) == "number" and
		type(bgColor[2]) == "number" and
		type(bgColor[3]) == "number", ("%s-GuiFactory. %q must be a numeric indexed table with at least 3 values, each of numeric type"):format(self.name, "bgColor")) end
	if borderColor then 	assert(type(borderColor) 	== "table" and #borderColor > 2 and 
		type(borderColor[1]) == "number" and
		type(borderColor[2]) == "number" and
		type(borderColor[3]) == "number", ("%s-GuiFactory. %q must be a numeric indexed table with at least 3 values, each of numeric type"):format(self.name, "borderColor")) end
	
	local s = self.s[gType]
	
	local group = AceGUI:Create("UIF-InlineGroup")
	group:SetLayout("Flow")
	group:SetFullWidth(true)
	group:SetTitle(text)
	group:SetFont(s.font or self.s.font, s.fontSize or self.s.fontSize, s.fontFlags or self.s.fontFlags)
	group:SetFontColor(s.fontColor or self.s.fontColor)
	group:SetBGColor(bgColor or s.bgColor or self.s.bgColor)
	group:SetBorderColor(borderColor or s.borderColor or self.s.borderColor)
	
	return group
end

local function InlineGroup1(self, text, bgColor, borderColor)
	return IGroup("InlineGroup1", self, text, bgColor, borderColor)
end
local function InlineGroup2(self, text, bgColor, borderColor)
	return IGroup("InlineGroup2", self, text, bgColor, borderColor)
end
local function InlineGroup3(self, text, bgColor, borderColor)
	return IGroup("InlineGroup3", self, text, bgColor, borderColor)
end
AddEmbed("InlineGroup1", InlineGroup1)
AddEmbed("InlineGroup2", InlineGroup2)
AddEmbed("InlineGroup3", InlineGroup3)
AddEmbed("InlineGroup", InlineGroup1)

-- Mewline
local function NewLine(self, height)
	local t = AceGUI:Create("UIF-NewLine")
	t:SetHeight(height or 2)
	t:SetFullWidth(true)
	return t
end
AddEmbed("NewLine", NewLine)

local function Spacer(self, width)
	local t = AceGUI:Create("UIF-NewLine")
	t:SetWidth(width or 2)
	t:SetFullWidth(false)
	t:SetHeight(10)		
	return t
end
AddEmbed("Spacer", Spacer)

----------------------
-- Changing widgets

-- Used for update on release widgets
local function UpdateTrigger(widget, event, ...)
	local self = widget:GetUserData("self")	
	local db = widget:GetUserData("db")
	local key = widget:GetUserData("key")
	local func = widget:GetUserData("extraCallback")
	local TriggerGlobalUpdate = widget:GetUserData("TriggerGlobalUpdate")
	
	if db then
		if select("#", ...) > 1 then
			for i = 1, select("#", ...) do
				db[key] = db[key] or {}
				if type(db[key]) ~= "table" then
					db[key] = {}
				end
				db[key][i] = select(i, ...)
			end
		else
			if widget.min then
				local value = ...
				if value < widget.min then value = widget.min end
				if value > widget.max then value = widget.max end
				db[key] = value
			else
				db[key] = ...
			end
		end
	end
	
	if widget.SetValue then
		if widget.min then
			local value = ...
			if value < widget.min then value = widget.min end
			if value > widget.max then value = widget.max end
			widget:SetValue(value)
			if widget.editbox then
				widget.editbox:ClearFocus()
			end
		else
			widget:SetValue(...)
		end
	end		
	if func then func(widget, event, ...) end
	if widget.SetColor then
		widget:SetColor(...)
	end
	if TriggerGlobalUpdate then
		if self.valuesChangedCallback then 
			for i, func in pairs(self.valuesChangedCallback) do
				func(self)
			end
		end
	end
end

local function ConfirmPupup(widget, event, ...)
	if not StaticPopupDialogs["AEGUIFACTORY_CONFIRM_DIALOG"] then
		StaticPopupDialogs["AEGUIFACTORY_CONFIRM_DIALOG"] = {}
	end
	local t = StaticPopupDialogs["AEGUIFACTORY_CONFIRM_DIALOG"]
	for k in pairs(t) do
		t[k] = nil
	end
	t.text = "Are you sure?"
	t.button1 = ACCEPT
	t.button2 = CANCEL
	local data = {...}
	local dialog, oldstrata
	t.OnAccept = function()
		UpdateTrigger(widget, event, unpack(data))
		if dialog and oldstrata then
			dialog:SetFrameStrata(oldstrata)
		end
	end
	t.OnCancel = function()
		if dialog and oldstrata then
			dialog:SetFrameStrata(oldstrata)
		end
		local self = widget:GetUserData("self")
		local TriggerGlobalUpdate = widget:GetUserData("TriggerGlobalUpdate")
		if TriggerGlobalUpdate then
			if self.valuesChangedCallback then 
				for i, func in pairs(self.valuesChangedCallback) do
					func(self)
				end
			end
		end
	end
	for i = 1, select('#', ...) do
		t[i] = select(i, ...) or false
	end
	t.timeout = 0
	t.whileDead = 1
	t.hideOnEscape = 1

	dialog = StaticPopup_Show("AEGUIFACTORY_CONFIRM_DIALOG")
	if dialog then
		oldstrata = dialog:GetFrameStrata()
		dialog:SetFrameStrata("TOOLTIP")
	end
end


local function SetGUIOption(widget, event, ...)
	local self = widget:GetUserData("self")
	local db = widget:GetUserData("db")
	local key = widget:GetUserData("key")
	local UpdateOnMouseUp = widget:GetUserData("UpdateOnMouseUP")
	local TriggerGlobalUpdate = widget:GetUserData("TriggerGlobalUpdate")
	local func = widget:GetUserData("extraCallback")
	local confirm = widget:GetUserData("confirm")
	
	if confirm then ConfirmPupup(widget, event, ...) return end

	if db and key then	
		if select("#", ...) > 1 then
			for i = 1, select("#", ...) do
				db[key] = db[key] or {}
				if type(db[key]) ~= "table" then
					db[key] = {}
				end
				db[key][i] = select(i, ...)
			end
		else
			if widget.min then
				local value = ...
				if value < widget.min then value = widget.min end
				if value > widget.max then value = widget.max end
				db[key] = value
			else
				db[key] = ...
			end
		end
	elseif db then
		local item, value = ...
		db[item] = value
	end
	
	if key and widget.SetValue then
		if widget.min then
			local value = ...
			if value < widget.min then value = widget.min end
			if value > widget.max then value = widget.max end
			widget:SetValue(value)
		else
			widget:SetValue(...)
		end
	end
	
	if widget.SetColor then
		widget:SetColor(...)
	end
	
	if func then func(widget, event, ...) end	
	if TriggerGlobalUpdate then
		if self.valuesChangedCallback and not UpdateOnMouseUp then 
			for i, func in pairs(self.valuesChangedCallback) do
				func(self)
			end
		end
	end
	
	if key then AceGUI:ClearFocus() end
end

local function Slider(self, text, db, key, min, max, step, callback, relativeWidth)
	assert(text and type(text) == "string", ("%s-GuiFactory. %q must be a string"):format(self.name, "text"))
	assert(db and type(db) == "table", ("%s-GuiFactory. %q must be a table"):format(self.name, "db"))
	assert(key, ("%s-GuiFactory. %q must be supplied"):format(self.name, "key"))
	assert(db[key], ("%s-GuiFactory. %q does not contain %q"):format(self.name, "db", key))
	if callback then assert(type(callback) == "function", ("%s-GuiFactory. %q must be a function"):format(self.name, "callback")) end
	if min then assert(type(min) == "number", ("%s-GuiFactory. %q must be a number"):format(self.name, "min")) end
	if max then assert(type(max) == "number", ("%s-GuiFactory. %q must be a number"):format(self.name, "max")) end
	if step then assert(type(step) == "number", ("%s-GuiFactory. %q must be a number"):format(self.name, "step")) end
	if relativeWidth then assert(type(relativeWidth) == "number", ("%s-GuiFactory. %q must be a number"):format(self.name, "relativeWidth")) end
	
	local s = self.s["Slider"]	
	
	local slider = AceGUI:Create("UIF-Slider")
	slider:SetLabel(text)
	slider:SetFont(s.font or self.s.font, s.fontSize or self.s.fontSize, s.fontFlags or self.s.fontFlags)
	slider:SetFontColor(s.fontColor or self.s.fontColor)
	slider:SetSliderValues(min or 0, max or 100, step or 1)
	slider:SetValue(db[key])	
	slider:SetUserData("db", db)
	slider:SetUserData("key", key)
	slider:SetUserData("extraCallback", callback)
	slider:SetUserData("self", self)
	slider:SetUserData("UpdateOnMouseUP", true)
	slider:SetCallback("OnValueChanged", SetGUIOption)
	slider:SetCallback("OnMouseUp", UpdateTrigger)
	
	if relativeWidth then slider:SetRelativeWidth(relativeWidth) end
	
	return slider
end
AddEmbed("Slider", Slider)

local function PositionSlider(self, type, text, db, key, step, callback, relativeWidth)
	local min, max
	if string.lower(type) == "x" then
		min = -floor(GetScreenWidth() * UIParent:GetEffectiveScale())
		max = floor(GetScreenWidth() * UIParent:GetEffectiveScale())
	else
		min = -floor(GetScreenHeight() * UIParent:GetEffectiveScale()) 
		max = floor(GetScreenHeight() * UIParent:GetEffectiveScale())
	end
	
	return Slider(self, text, db, key, min, max, step, callback, relativeWidth)
end
AddEmbed("PositionSlider", PositionSlider)

local function CheckBox(self, text, db, key, callback, description, relativeWidth, globalUpdate)
	assert(text and type(text) == "string", ("%s-GuiFactory. %q must be a string"):format(self.name, "text"))
	assert(db and type(db) == "table", ("%s-GuiFactory. %q must be a table"):format(self.name, "db"))
	assert(key, ("%s-GuiFactory. %q must be supplied"):format(self.name, "key"))
	if callback then assert(type(callback) == "function", ("%s-GuiFactory. %q must be a function"):format(self.name, "callback")) end
	if relativeWidth then assert(type(relativeWidth) == "number", ("%s-GuiFactory. %q must be a number"):format(self.name, "relativeWidth")) end
	
	local s = self.s["CheckBox"]
	
	local check = AceGUI:Create("UIF-CheckBox")
	check:SetFullWidth(true)
	check:SetLabel(text)
	check:SetValue(db[key])
	check:SetFont(s.font or  self.s.font, s.fontSize or self.s.fontSize, s.fontFlags or self.s.fontFlags)
	check:SetFontColor(s.fontColor or self.s.fontColor)
	if description then
		check:SetDescription(description)
	end
	
	check:SetUserData("db", db)
	check:SetUserData("key", key)
	check:SetUserData("extraCallback", callback)
	check:SetUserData("self", self)
	check:SetUserData("TriggerGlobalUpdate", globalUpdate)
	check:SetCallback("OnValueChanged", SetGUIOption)	
	
	if relativeWidth then check:SetRelativeWidth(relativeWidth) end
	
	return check
end
AddEmbed("CheckBox", CheckBox)

local function ColorSelect(self, text, db, key, callback, hasAlpha, relativeWidth)
	assert(text and type(text) == "string", ("%s-GuiFactory. %q must be a string"):format(self.name, "text"))
	assert(db and type(db) == "table", ("%s-GuiFactory. %q must be a table"):format(self.name, "db"))
	assert(key, ("%s-GuiFactory. %q must be supplied"):format(self.name, "key"))
	if callback then assert(type(callback) == "function", ("%s-GuiFactory. %q must be a function"):format(self.name, "callback")) end
	if hasAlpha then assert(hasAlpha and type(hasAlpha) == "boolean", ("%s-GuiFactory. %q must be a boolean"):format(self.name, "hasAlpha")) end
	if relativeWidth then assert(type(relativeWidth) == "number", ("%s-GuiFactory. %q must be a number"):format(self.name, "relativeWidth")) end
	
	local s = self.s["CheckBox"]
	
	local color = AceGUI:Create("UIF-ColorPicker")
	color:SetLabel(text)
	color:SetFont(s.font or self.s.font, s.fontSize or self.s.fontSize, s.fontFlags or self.s.fontFlags)
	color:SetFontColor(s.fontColor or self.s.fontColor)
	if db[key] and type(db[key]) == "table" then
		color:SetColor(unpack(db[key]))
	end
	color:SetHasAlpha(hasAlpha)
	
	color:SetUserData("db", db)
	color:SetUserData("key", key)
	color:SetUserData("extraCallback", callback)
	color:SetUserData("self", self)
	color:SetCallback("OnValueChanged", SetGUIOption)
	color:SetUserData("UpdateOnMouseUP", true)
	color:SetCallback("OnValueConfirmed", UpdateTrigger)	
	
	if relativeWidth then color:SetRelativeWidth(relativeWidth) end
	
	return color
end
AddEmbed("ColorSelect", ColorSelect)

-----------------------
-- Other

InternalButton = function(self)
	local s = self.s["Button"]
	
	local color = color or s.fontColor or self.s.fontColor
	
	local button = AceGUI:Create("UIF-Button")
	button:SetText(text)
	button:SetFont(font or s.font or self.s.font, size or s.fontSize or self.s.fontSize, flags or s.fontFlags or self.s.fontFlags)
	button:SetFontColor(color)
	
	return button
end

local function Button(self, text, callback, font, size, flags, color, relativeWidth)
	assert(text and type(text) == "string", ("%s-GuiFactory. %q must be a string"):format(self.name, "text"))
	if color then 	assert(type(color) 	== "table" and color[1] and #color > 2 and 
		type(color[1]) == "number" and
		type(color[2]) == "number" and
		type(color[3]) == "number", ("%s-GuiFactory. %q must be a numeric indexed table with at least 3 values, each of numeric type"):format(self.name, "color")) end
	if size then 	assert(type(size) 	== "number", ("%s-GuiFactory. %q must be a number"):format(self.name, "size")) end
	if font then	assert(type(font) 	== "string", ("%s-GuiFactory. %q must be a string"):format(self.name, "font")) end
	if flags then 	assert(type(flags) 	== "string", ("%s-GuiFactory. %q must be a string"):format(self.name, "flags")) end
	
	local s = self.s["Button"]
	
	color = color or s.fontColor or self.s.fontColor
	
	local button = AceGUI:Create("UIF-Button")
	button:SetText(text)
	button:SetFont(font or s.font or self.s.font, size or s.fontSize or self.s.fontSize, flags or s.fontFlags or self.s.fontFlags)
	button:SetFontColor(color)
	
	button:SetUserData("self", self)
	button:SetUserData("extraCallback", callback)
	button:SetCallback("OnClick", SetGUIOption)	
	button:SetUserData("UpdateOnMouseUP", true)
	button:SetCallback("OnMouseUp", UpdateTrigger)
		
	if not relativeWidth then
		button:SetWidth(button.text:GetStringWidth() + 30)
	else
		button:SetRelativeWidth(relativeWidth)
	end
	
	return button
end
AddEmbed("Button", Button)

----------------------
-- Dropdown

InternalDrop = function(self, text, callback, list, relativeWidth)
	local s = self.s["Dropdown"]

	local drop = AceGUI:Create("UIF-Dropdown")
	drop:SetItemFont(s.itemFont or self.s.font, s.itemFontSize or self.s.fontSize, s.itemFontFlags or self.s.fontFlags)
	drop:SetItemFontColor(s.itemFontColor or self.s.fontColor)
	drop:SetFont(s.font or self.s.font, s.fontSize or self.s.fontSize, s.fontFlags or self.s.fontFlags)
	drop:SetFontColor(s.fontColor or self.s.fontColor)
	
	drop:SetUserData("self", self)
	drop:SetLabel(text)
	drop:SetList(list)
	drop:SetUserData("extraCallback", callback)
	drop:SetCallback("OnValueChanged", SetGUIOption)
	if relativeWidth then drop:SetRelativeWidth(relativeWidth) end
	
	return drop
end
AddEmbed("SimpleDropdown", InternalDrop)

local function Dropdown(self, text, db, key, callback, list, relativeWidth, globalUpdate)
	assert(text and type(text) == "string", ("%s-GuiFactory. %q must be a string"):format(self.name, "text"))
	assert(db and type(db) == "table", ("%s-GuiFactory. %q must be a table"):format(self.name, "db"))
	assert(key, ("%s-GuiFactory. %q must be supplied"):format(self.name, "key"))
	if callback then assert(type(callback) == "function", ("%s-GuiFactory. %q must be a function"):format(self.name, "callback")) end
	if relativeWidth then assert(type(relativeWidth) == "number", ("%s-GuiFactory. %q must be a number"):format(self.name, "relativeWidth")) end

	local drop = InternalDrop(self)
	drop:SetLabel(text)
	
	drop:SetUserData("db", db)
	drop:SetUserData("key", key)
	drop:SetUserData("self", self)
	drop:SetList(list)	
	drop:SetUserData("extraCallback", callback)
	drop:SetCallback("OnValueChanged", SetGUIOption)
	drop:SetValue(db[key])
	
	drop:SetUserData("TriggerGlobalUpdate", globalUpdate)
	
	if relativeWidth then drop:SetRelativeWidth(relativeWidth) end
	
	return drop
end
AddEmbed("Dropdown", Dropdown)

local function MultiSelectDropdown(self, text, db, callback, list, relativeWidth)
	assert(text and type(text) == "string", ("%s-GuiFactory. %q must be a string"):format(self.name, "text"))
	assert(db and type(db) == "table", ("%s-GuiFactory. %q must be a table"):format(self.name, "db"))
	if callback then assert(type(callback) == "function", ("%s-GuiFactory. %q must be a function"):format(self.name, "callback")) end
	if relativeWidth then assert(type(relativeWidth) == "number", ("%s-GuiFactory. %q must be a number"):format(self.name, "relativeWidth")) end
	
	local drop = InternalDrop(self)
	drop:SetLabel(text)
	drop:SetMultiselect(true)
	
	drop:SetUserData("db", db)
	drop:SetUserData("self", self)
	if list then
		drop:SetList(list)
		for i in pairs(list) do
			if db[i] then drop:SetItemValue(i, true) end
		end
	end
	drop:SetUserData("extraCallback", callback)
	drop:SetCallback("OnValueChanged", SetGUIOption)
	
	if relativeWidth then drop:SetRelativeWidth(relativeWidth) end
	
	return drop
end
AddEmbed("MultiSelectDropdown", MultiSelectDropdown)

local function LSMDropdown(self, dtype, text, db, key, callback, relativeWidth)
	assert(text and type(text) == "string", ("%s-GuiFactory. %q must be a string"):format(self.name, "text"))
	assert(db and type(db) == "table", ("%s-GuiFactory. %q must be a table"):format(self.name, "db"))
	assert(key, ("%s-GuiFactory. %q must be supplied"):format(self.name, "key"))
	if callback then assert(type(callback) == "function", ("%s-GuiFactory. %q must be a function"):format(self.name, "callback")) end
	if relativeWidth then assert(type(relativeWidth) == "number", ("%s-GuiFactory. %q must be a number"):format(self.name, "relativeWidth")) end

	local drop
	local dtype = string.lower(dtype)
	if dtype == "statusbar" then
		drop = AceGUI:Create("LSM30_Statusbar")
		drop:SetList(LSM:HashTable("statusbar"))
	elseif dtype == "font" then
		drop = AceGUI:Create("LSM30_Font")
		drop:SetList(LSM:HashTable("font"))
	elseif dtype == "background" then
		drop = AceGUI:Create("LSM30_Background")
		drop:SetList(LSM:HashTable("background"))
	elseif dtype == "border" then
		drop = AceGUI:Create("LSM30_Border")
		drop:SetList(LSM:HashTable("border"))
	elseif dtype == "sound" then
		drop = AceGUI:Create("LSM30_Sound")
		drop:SetList(LSM:HashTable("sound"))
	else
		assert(drop ~= nil, ("%s-GuiFactory. %q is not a valid LSM dropdown."):format(self.name, "dtype"))
	end
	
	
	drop:SetLabel(text)	
	drop:SetValue(db[key])
	
	drop:SetUserData("db", db)
	drop:SetUserData("key", key)
	drop:SetUserData("extraCallback", callback)
	drop:SetUserData("self", self)
	drop:SetCallback("OnValueChanged", SetGUIOption)
	
	if relativeWidth then drop:SetRelativeWidth(relativeWidth) end
	
	return drop
end
AddEmbed("LSMDropdown", LSMDropdown)

-- Profile
local AceProfileOption
do	
	local function GetAllPorfiles(db)
		local profiles = {	
			["Default"] = "Default",
			[db.keys.char] = db.keys.char,
			[db.keys.realm] = db.keys.realm,
			[db.keys.class] = UnitClass("player")
		}
		local ExistingProfiles =   {}
		local count = 0
		
		for i, profileName in pairs(db:GetProfiles()) do
			profiles[profileName] = profileName
			count = count + 1
		end
		
		return profiles, count
	end

	local function GetExistingProfiles(db, nocurrent)
		local profiles = {}
		local currentProfile = db:GetCurrentProfile()
		local count = 0
		
		for i, profileName in pairs(db:GetProfiles()) do
			if not (nocurrent and profileName == currentProfile) then
				profiles[profileName] = profileName
				count = count + 1
			end
		end
		
		return profiles, count
	end

	local function RefreshProfileLists(widget)
		local SelectProfile = widget:GetUserData("SelectProfile")
		if not SelectProfile then return end
		local CopyProfile = widget:GetUserData("CopyProfile")
		local DeleteProfile = widget:GetUserData("DeleteProfile")
		local db = SelectProfile:GetUserData("Database")
		
		local profiles, count = GetAllPorfiles(db)
		SelectProfile:SetList(profiles)
		SelectProfile:SetValue(db:GetCurrentProfile())
		profiles, count = GetExistingProfiles(db, true)
		CopyProfile:SetList(profiles)
		CopyProfile:SetDisabled(count == 0)
		CopyProfile:SetValue()
		DeleteProfile:SetList(profiles)
		DeleteProfile:SetDisabled(count == 0)
		DeleteProfile:SetValue()
	end

	-- Create a group containing options to handle AceDB-3.0 profiles.
	-- @paramsig [self ,] db
	-- @param self Table that is the factory itself, Not required when used via Factory:AceProfileOption(...)
	-- @param db AceDB-3.0 database object to create the profile options for.
	AceProfileOption = function(self, db)
		assert(db and db.ResetDB, ("%s-GuiFactory. %q must proper AceDB object."):format(self.name, "db"))
		
		local group = self:InlineGroup("Profile Settings")
		local profiles, count, text
		
		local SelectProfile = InternalDrop(self)
		SelectProfile:SetLabel("Profiles")
		SelectProfile:SetUserData("Database", db)
		SelectProfile:SetCallback("OnValueChanged", function(widget, event, value)
			widget:GetUserData("Database"):SetProfile(value)
			RefreshProfileLists(group)
		end)
		group:AddChild(SelectProfile)
		
		local ResetProfile = InternalButton(self)
		ResetProfile:SetText("Reset")
		ResetProfile:SetWidth(ResetProfile.text:GetStringWidth() + 30)
		ResetProfile:SetUserData("Database", db)
		ResetProfile:SetUserData("self", self)
		ResetProfile:SetUserData("extraCallback", function(widget, event)
			widget:GetUserData("Database"):ResetProfile()
		end)
		ResetProfile:SetCallback("OnClick", SetGUIOption)	
		ResetProfile:SetUserData("confirm", true)
		group:AddChild(ResetProfile)
		
		group:AddChild(self:NewLine(15))
		group:AddChild(self:NormalText("Copy a profile and replace the current profiles settings."))
		local CopyProfile = InternalDrop(self)
		CopyProfile:SetLabel("Copy Profile")
		CopyProfile:SetUserData("Database", db)
		CopyProfile:SetCallback("OnValueChanged", function(widget, event, value)
			local db = widget:GetUserData("Database")
			db:CopyProfile(value)
			RefreshProfileLists(group)
		end)
		group:AddChild(CopyProfile)
		
		group:AddChild(self:NewLine(15))
		group:AddChild(self:NormalText("Delete one of the existing profiles"))
		local DeleteProfile = InternalDrop(self)
		DeleteProfile:SetLabel("Delete Profile")
		DeleteProfile:SetUserData("Database", db)
		DeleteProfile:SetUserData("self", self)
		DeleteProfile:SetUserData("extraCallback", function(widget, event, value)			
			local db = widget:GetUserData("Database")
			if value then
				db:DeleteProfile(value)
			end
			RefreshProfileLists(group)
		end)
		DeleteProfile:SetCallback("OnValueChanged", SetGUIOption)	
		DeleteProfile:SetUserData("confirm", true)
		group:AddChild(DeleteProfile)		
		
		group:AddChild(self:NewLine(15))
		group:AddChild(self:NormalText("Create a new profile, it will then become the active profile."))
		local CreateProfile = AceGUI:Create("EditBox")
		CreateProfile:SetLabel("Create Profile")
		CreateProfile:SetUserData("Database", db)
		CreateProfile:SetCallback("OnEnterPressed", function(widget, event, value)
			local db = widget:GetUserData("Database")
			db:SetProfile(value)
			widget.editbox:ClearFocus()
			widget:SetText()
			RefreshProfileLists(group)
		end)
		group:AddChild(CreateProfile)
		
		group:SetUserData("SelectProfile", SelectProfile)
		group:SetUserData("CopyProfile", CopyProfile)
		group:SetUserData("DeleteProfile", DeleteProfile)
		
		RefreshProfileLists(group)
		
		return group		
	end
end
AddEmbed("AceProfileOption", AceProfileOption)

local function SetValuesChangedCallback(self, func)
	assert(type(func) == "function", "The callback must be a function")
	self.valuesChangedCallback = self.valuesChangedCallback or {} 
	tinsert(self.valuesChangedCallback, func)
end
AddEmbed("SetValuesChangedCallback", SetValuesChangedCallback)

for fName, factory in pairs(UIF.factories) do
	Embed(factory)
end

-- Defaults
local defaultFont, defualtFondSize, defaultFontFlags = GameFontNormal:GetFont()

UIF.defaults = {
	font = defaultFont,
	fontSize = defualtFondSize,
	fontColor = {177/255, 219/255, 255/255},
	fontFlags = defaultFontFlags,
	borderColor = {0.2,0.3,0.37,1},
	bgColor = {0.11,0.16,0.19,1},
	
	MainTitle = {
		fontSize = 30,
		fontColor = {0.4, 0.6, 0.8},
		fontFlags = "OUTLINE"
	},
	
	-- Titles
	Title1 = {
		fontSize = 30,
		fontColor = {255/255, 248/255, 53/255},
		fontFlags = "OUTLINE"
	},
	Title2 = {
		fontSize = 20,
		fontColor = {18/255, 157/255, 143/255},
		fontFlags = "OUTLINE"
	},
	Title3 = {
		fontSize = 18,
		fontColor = {18/255, 157/255, 143/255},
		fontFlags = "OUTLINE"
	},
	
	-- Mornal texts
	Text1 = {
		fontSize = 16,
		fontColor = {177/255, 219/255, 255/255},
	},
	Text2 = {
	},
	Text3 = {
	},
	
	-- Lists
	ListLevel1 = {
		fontSize = 16,
		fontColor = {0.96, 0.93, 0.49},
	},
	ListLevel2 = {
	},
	ListLevel3 = {
	},

	-- Frame
	Frame = {
		fontSize = 25,
		bgColor = {0.11,0.16,0.19,0.8},
	},
	DropdownGroup = {
	},
	Dropdown = {
		itemFontSize = 18,
	},
	TreeGroup = {
		fontColor = {0.4, 0.6, 0.8},		
	},
	TabGroup1 = {	
		fontSize = 20,
		tabFontSize = 35,
		bgColor = {0.11,0.16,0.19,1},
		borderColor = {0.2,0.3,0.37,1},
	},
	TabGroup2 = {	
		fontSize = 20,
		fontFlags = "OUTLINE",
		bgColor = {40/255, 45/255, 70/255},
		borderColor = {81/255, 96/255, 106/255},
		fontColor = {207/255, 218/255, 85/255},
	},
	TabGroup3 = {	
		fontSize = 20,
		fontFlags = "OUTLINE",
		bgColor = {40/255, 45/255, 70/255},
		borderColor = {81/255, 96/255, 106/255},
		fontColor = {207/255, 218/255, 85/255},
	},
	InlineGroup1 = {
		fontFlags = "OUTLINE",
		fontSize = 22,
	},
	InlineGroup2 = {
		bgColor = {40/255, 45/255, 70/255},
		borderColor = {81/255, 96/255, 106/255},
		fontColor = {207/255, 218/255, 85/255},
		fontSize = 22,
	},
	InlineGroup3 = {
		bgColor = {40/255, 55/255, 75/255},
		borderColor = {81/255, 96/255, 106/255},
		fontColor = {207/255, 100/255, 85/255},
		fontSize = 20,
	},
	Button = {
	},
	Slider = {		
	},
	CheckBox = {
	},
}