local AceGUI = LibStub("AceGUI-3.0")

local new, del
do
	local pool = setmetatable({},{__mode='k'})
	function new()
		local t = next(pool)
		if t then
			pool[t] = nil
			return t
		else
			return {}
		end
	end
	function del(t)
		for k in pairs(t) do
			t[k] = nil
		end	
		pool[t] = true
	end
end

do
	local Type = "UIF-TreeGroup"
	local Version = 31
	
	local function OnRelease(self)
        
		self.frame:ClearAllPoints()
		self.frame:Hide()
		self.status = nil
		for k, v in pairs(self.localstatus) do
			if k == "groups" then
				for k2 in pairs(v) do
					v[k2] = nil
				end
			else
				self.localstatus[k] = nil
			end
		end
		self.localstatus.scrollvalue = 0
		self.localstatus.treewidth = DEFAULT_TREE_WIDTH
		self.localstatus.treesizable = DEFAULT_TREE_SIZABLE
		
		self.tree = nil
	end
	
	local function BuildUniqueValue(...)
		local n = select('#', ...)
		if n == 1 then
			return ...
		else
			return (...).."\001"..BuildUniqueValue(select(2,...))
		end
	end
	
	local function GetTableData(t, key, entry)
		for i, v in pairs(t) do
			if v[key] == entry then return v end
		end
	end
	
	local function FindInTree(tree, ...)
		local n = select("#", ...)
		for i, data in pairs(tree) do
			local t = ...
			if data.value == t and n == 1 then
				return data
			else
				if data.children and n > 1 then
					return FindInTree(data.children, select(2, ...))
				end
			end
		end
	end
	
	local function AddLevel(t, d)
		local newLevel = {value = d.value, text = d.text, order = d.order or #t + 100}
		tinsert(t, newLevel)
		table.sort(t, function(a, b) return a.order < b.order end)
		return newLevel
	end
	
	
	local function AddGroup(self, path, group, icon, re)
		
		local tree = re or self.tree
		if not tree then
			tree = {}
			self.tree = tree
		end
		
		local buildPath
		
		for i, PathPart in pairs(path) do
			buildPath = buildPath and buildPath.."\001"..PathPart.value or PathPart.value
			
			local existingData = FindInTree(self.tree, string.split("\001", buildPath))
			
			if not existingData then				
				local t = AddLevel(tree, PathPart)
				if not path[i + 1] then
					t.icon = icon
					t.group = group
				else
					t.children = t.children or {}
					tree = t.children
				end
			else				
				if not path[i + 1] then
					if existingData.group then
						error("Overwriting "..PathPart.text)
					end
					existingData.group = group
					existingData.icon = icon
				else
					existingData.children = existingData.children or {}
					tree = existingData.children
				end
			end
		end		
		
		self:RefreshTree()
	end	
	
	local function Select(self, uniquevalue, ...)
		self.filter = false
		local status = self.status or self.localstatus
		local groups = status.groups
		for i = 1, select('#', ...) do
			groups[BuildUniqueValue(select(i, ...))] = true
		end
		status.selected = uniquevalue
		self:RefreshTree()
		local data = FindInTree(self.tree, string.split("\001", uniquevalue))
		if data then
			self:ReleaseChildren()			
			if data.group then
				local scroll = AceGUI:Create("ScrollFrame")
				scroll:SetLayout("Flow")
				self:AddChild(scroll)
				scroll:AddChildren(data.group())
				scroll:FixScroll()
			end
		end
		self:Fire("OnGroupSelected", uniquevalue)
	end
	
	local function SetSelected(self, value)
		local status = self.status or self.localstatus
		if status.selected ~= value then
			status.selected = value
			local data = FindInTree(self.tree, string.split("\001", value))
			if data then
				self:ReleaseChildren()	
				if data.group then
					local scroll = AceGUI:Create("ScrollFrame")
					scroll:SetLayout("Flow")
					self:AddChild(scroll)
					scroll:AddChildren(data.group())
					scroll:FixScroll()
				end
			end
			self:Fire("OnGroupSelected", value)
		end
	end
	
	local function SetFont(self, font, size, flags)
		self.fontO = self.fontO or CreateFont("UIFTreeFont")
		self.fontO:SetFont(font, size, flags)
		self.fontOH = self.fontOH or CreateFont("UIFTreeFontH")
		self.fontOH:SetFont(font, size + 3, "OUTLINE")
		self.useCustomFont = true
	end
	
	local function SetFontColor(self, color)
		local font, size = GameFontNormal:GetFont()
		if not self.fontO then
			self.fontO = self.fontO or CreateFont("UIFTreeFont")
			self.fontO:SetFont(font, size, "")
		end
		if not self.fontOH then			
			self.fontOH = self.fontOH or CreateFont("UIFTreeFontH")
			local font, size = GameFontNormal:GetFont()
			self.fontOH:SetFont(font, size + 3, "OUTLINE")			
		end
		self.fontO:SetTextColor(unpack(color))
		self.fontOH:SetTextColor(unpack(color))
		self.useCustomFont = true
	end
	
	local function SetSubFont(self, font, size, flags)
		self.subFont = self.subFont or CreateFont("UIFTreeSubFont")
		self.subFont:SetFont(font, size, flags)
		self.subFontH = self.subFontH or CreateFont("UIFTreeSubFontH")
		self.subFontH:SetFont(font, size + 3, "OUTLINE")
		self.useCustomSubFont = true
	end
	
	local function SetSubColor(self, color)
		local font, size = GameFontNormal:GetFont()
		if not self.subFont then
			self.subFont = self.subFont or CreateFont("UIFTreeSubFont")
			self.subFont:SetFont(font, size, "")
		end
		if not self.subFontH then
			self.subFontH = self.subFontH or CreateFont("UIFTreeSubFontH")
			self.subFontH:SetFont(font, size + 3, "OUTLINE")
		end
		self.subFontH:SetTextColor(unpack(color))
		self.subFont:SetTextColor(unpack(color))
		self.useCustomSubFont = true
	end
	
	local function FirstFrameUpdate(this)
		local self = this.obj
		this:SetScript("OnUpdate",nil)
		self:RefreshTree()
	end
	
	local function ResizeUpdate(this)
		this.obj:RefreshTree()
	end
	
	local function UpdateButton(button, treeline, selected, canExpand, isExpanded)
		local self = button.obj
		local toggle = button.toggle
		local frame = self.frame
		local text = treeline.text or ""
		local icon = treeline.icon
		local iconCoords = treeline.iconCoords
		local level = treeline.level
		local value = treeline.value
		local uniquevalue = treeline.uniquevalue
		local disabled = treeline.disabled
		
		button.treeline = treeline
		button.value = value
		button.uniquevalue = uniquevalue
		if selected then
			button:LockHighlight()
			button.selected = true
		else
			button:UnlockHighlight()
			button.selected = false
		end
		local normalTexture = button:GetNormalTexture()
		local line = button.line
		button.level = level
		if ( level == 1 ) then
			button:SetNormalFontObject("GameFontNormal")
			button:SetHighlightFontObject("GameFontHighlight")
			button.text:SetPoint("LEFT", (icon and 16 or 0) + 8, 2)
			if self.useCustomFont then 
				button:SetNormalFontObject("UIFTreeFont") 
				button:SetHighlightFontObject("UIFTreeFontH")
			end
		else
			button:SetNormalFontObject("GameFontHighlightSmall")
			button:SetHighlightFontObject("GameFontHighlightSmall")
			button.text:SetPoint("LEFT", (icon and 16 or 0) + 8 * level, 2)
			if self.useCustomSubFont then 
				button:SetNormalFontObject("UIFTreeSubFont") 
				button:SetHighlightFontObject("UIFTreeSubFontH")
			end
		end
		
		if disabled then
			button:EnableMouse(false)
			button.text:SetText("|cff808080"..text..FONT_COLOR_CODE_CLOSE)
		else			
			button.text:SetText(text)
			button:EnableMouse(true)
		end
		
		if icon then
			button.icon:SetTexture(icon)
			button.icon:SetPoint("LEFT", button, "LEFT", 8 * level, (level == 1) and 0 or 1)
		else
			button.icon:SetTexture(nil)
		end
		
		if iconCoords then
			button.icon:SetTexCoord(unpack(iconCoords))
		else
			button.icon:SetTexCoord(0, 1, 0, 1)
		end
		
		if canExpand then
			if not isExpanded then
				toggle:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-UP")
				toggle:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-DOWN")
			else
				toggle:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-UP")
				toggle:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-DOWN")
			end
			toggle:Show()
		else
			toggle:Hide()
		end
	end
	
	local function RefreshTree(self)
		local buttons = self.buttons 
		local lines = self.lines
		
		for i, v in ipairs(buttons) do
			v:Hide()
		end
		while lines[1] do
			local t = tremove(lines)
			for k in pairs(t) do
				t[k] = nil
			end
			del(t)
		end		
		
		if not self.tree then return end
		--Build the list of visible entries from the tree and status tables
		local status = self.status or self.localstatus
		local groupstatus = status.groups
		local tree = self.tree

		local treeframe = self.treeframe

		self:BuildLevel(tree, 1)
		
		local numlines = #lines
		
		local maxlines = (floor(((self.treeframe:GetHeight()or 0) - 20 ) / 18))
		
		local first, last
		
		if numlines <= maxlines then
			--the whole tree fits in the frame
			status.scrollvalue = 0
			self:ShowScroll(false)
			first, last = 1, numlines
		else
			self:ShowScroll(true)
			--scrolling will be needed
			self.noupdate = true
			self.scrollbar:SetMinMaxValues(0, numlines - maxlines)
			--check if we are scrolled down too far
			if numlines - status.scrollvalue < maxlines then
				status.scrollvalue = numlines - maxlines
				self.scrollbar:SetValue(status.scrollvalue)
			end
			self.noupdate = nil
			first, last = status.scrollvalue+1, status.scrollvalue + maxlines
		end
		
		local buttonnum = 1
		for i = first, last do
			local line = lines[i]
			local button = buttons[buttonnum]
			if not button then
				button = self:CreateButton()

				buttons[buttonnum] = button
				button:SetParent(treeframe)
				button:SetFrameLevel(treeframe:GetFrameLevel()+1)
				button:ClearAllPoints()
				if i == 1 then
					if self.showscroll then
						button:SetPoint("TOPRIGHT", self.treeframe,"TOPRIGHT",-22,-10)
						button:SetPoint("TOPLEFT", self.treeframe, "TOPLEFT", 0, -10)
					else
						button:SetPoint("TOPRIGHT", self.treeframe,"TOPRIGHT",0,-10)
						button:SetPoint("TOPLEFT", self.treeframe, "TOPLEFT", 0, -10)
					end
				else
					button:SetPoint("TOPRIGHT", buttons[buttonnum-1], "BOTTOMRIGHT",0,0)
					button:SetPoint("TOPLEFT", buttons[buttonnum-1], "BOTTOMLEFT",0,0)
				end
			end

			UpdateButton(button, line, status.selected == line.uniquevalue, line.hasChildren, groupstatus[line.uniquevalue] )
			button:Show()
			buttonnum = buttonnum + 1
		end

	end
	
	local function SetBorderColor(self, color)
		self.border:SetBackdropBorderColor(unpack(color))
		self.treeframe:SetBackdropBorderColor(unpack(color))
	end
	
	local function Constructor()
		local self = AceGUI:Create("TreeGroup")
		self.type = Type
		
		self.OnRelease = OnRelease
		
		self.AddGroup = AddGroup
		self.SetSelected = SetSelected
		self.Select = Select
		
		self.RefreshTree = RefreshTree
		
		self.SetFont = SetFont
		self.SetFontColor = SetFontColor
		self.SetSubFont = SetSubFont
		self.SetSubColor = SetSubColor
		self.SetBorderColor = SetBorderColor
		
		return self
	end
	
	AceGUI:RegisterWidgetType(Type,Constructor,Version)
end
