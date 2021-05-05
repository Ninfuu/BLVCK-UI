local AceGUI = LibStub("AceGUI-3.0")

local function fixlevels(parent,...)
	local i = 1
	local child = select(i, ...)
	while child do
		child:SetFrameLevel(parent:GetFrameLevel()+1)
		fixlevels(child, child:GetChildren())
		i = i + 1
		child = select(i, ...)
	end
end

local function fixstrata(strata, parent, ...)
	local i = 1
	local child = select(i, ...)
	parent:SetFrameStrata(strata)
	while child do
		fixstrata(strata, child, child:GetChildren())
		i = i + 1
		child = select(i, ...)
	end
end


do
	local widgetType = "UIFDropdown-Pullout"
	local widgetVersion = 107
	
	-- exported
	local function AddItem(self, item)
		self.items[#self.items + 1] = item
		
		local h = 0
		for i, item in pairs(self.items) do
			h = h + item.frame:GetHeight()
		end
		self.itemFrame:SetHeight(h)
		self.frame:SetHeight(min(h + 34, self.maxHeight)) -- +34: 20 for scrollFrame placement (10 offset) and +14 for item placement
		
		item.frame:SetPoint("LEFT", self.itemFrame, "LEFT")
		item.frame:SetPoint("RIGHT", self.itemFrame, "RIGHT")
		
		item:SetPullout(self)
		item:SetOnEnter(OnEnter)
	end
	
	-- exported
	local function Open(self, point, relFrame, relPoint, x, y)
		local items = self.items
		local frame = self.frame
		local itemFrame = self.itemFrame
		
		frame:SetPoint(point, relFrame, relPoint, x, y)

				
		local height = 8
		for i, item in pairs(items) do
			if i == 1 then
				item:SetPoint("TOP", itemFrame, "TOP", 0, -2)
			else
				item:SetPoint("TOP", items[i-1].frame, "BOTTOM", 0, 1)
			end
			
			item:Show()
			height = height + item.frame:GetHeight()
		end
		itemFrame:SetHeight(height)
		fixstrata("TOOLTIP", frame, frame:GetChildren())
		frame:Show()
		self:Fire("OnOpen")
	end	
	
	-- exported
	local function SetMaxHeight(self, height)
		self.maxHeight = height or defaultMaxHeight
		if self.frame:GetHeight() > height then
			self.frame:SetHeight(height)
		elseif (self.itemFrame:GetHeight() + 34) < height then
			self.frame:SetHeight(self.itemFrame:GetHeight() + 34) -- see :AddItem
		end
	end
	
	--[[ Constructor ]]--
	
	local function Constructor()
		local self = AceGUI:Create("Dropdown-Pullout")	
		self.type = widgetType
		
		self.AddItem = AddItem
		self.Open = Open
		self.SetMaxHeight = SetMaxHeight
		
		AceGUI:RegisterAsWidget(self)
		return self
	end
	AceGUI:RegisterWidgetType(widgetType, Constructor, widgetVersion)
end

do
	local widgetType = "UIF-Dropdown"
	local widgetVersion = 22
	
	local function OnPulloutOpen(this)
		local self = this.userdata.obj
		local value = self.value
		
		if not self.multiselect then
			for i, item in this:IterateItems() do
				item:SetValue(item.userdata.value == value)
			end
		end
		
		self.open = true
	end

	local function OnPulloutClose(this)
		local self = this.userdata.obj
		self.open = nil
		self:Fire("OnClosed")
	end
	
	local function OnAcquire(self)
		local pullout = AceGUI:Create("UIFDropdown-Pullout")
		self.pullout = pullout		
		pullout.userdata.obj = self
		pullout:SetCallback("OnClose", OnPulloutClose)
		pullout:SetCallback("OnOpen", OnPulloutOpen)
		self.pullout.frame:SetFrameLevel(self.frame:GetFrameLevel() + 1)
		fixlevels(self.pullout.frame, self.pullout.frame:GetChildren())
		self:SetHeight(44)
		self:SetWidth(200)
	end
	
	local function ShowMultiText(self)
		local text
		for i, widget in self.pullout:IterateItems() do			
			if widget.type == "Dropdown-Item-Toggle" or widget.type == "UIFDropdown-Item-Toggle" then
				if widget:GetValue() then
					if text then
						text = text..", "..widget:GetText()
					else
						text = widget:GetText()
					end
				end
			end
		end
		self:SetText(text)
	end
	
	local function SetFont(self, font, size, flags)
		self.text:SetFont(font, size, flags)
	end
	
	local function SetFontColor(self, color)		
		self.text:SetTextColor(unpack(color))
	end
	
	local function SetItemFont(self, font, size, flags)
		self.ItemFont = self.ItemFont or UIFDropdownItemFont or CreateFont("UIFDropdownItemFont")
		self.ItemFont:SetFont(font, size, flags)
		self.UseCustonItemFont = true
	end
	
	local function SetItemFontColor(self, color)
		local font, size, flags = GameFontNormalSmall:GetFont()
		if not self.ItemFont then
			self.ItemFont = self.ItemFont or UIFDropdownItemFont or CreateFont("UIFDropdownItemFont")
			self.ItemFont:SetFont(font, size, flags)
		end
		self.ItemFont:SetTextColor(unpack(color))
		self.UseCustonItemFont = true
	end
	
	local function OnItemValueChanged(this, event, checked)
		local self = this.userdata.obj
		
		if self.multiselect then
			self:Fire("OnValueChanged", this.userdata.value, checked)
			ShowMultiText(self)
		else
			if checked then
				self:SetValue(this.userdata.value)
				self:Fire("OnValueChanged", this.userdata.value)
			else
				this:SetValue(true)
			end
			if self.open then	
				self.pullout:Close()
			end
		end
	end
	
	local function SetValue(self, value)
		if self.list then
			if type(self.list[value]) == "table" then
				self:SetText(self.list[value].text or "")
			else
				self:SetText(self.list[value] or "")
			end
		end
		self.value = value
	end
	
	local function AddListItem(self, value, text, icon, disabled)
		local item = AceGUI:Create("UIFDropdown-Item-Toggle")
		if self.UseCustonItemFont then
			item:SetFont("UIFDropdownItemFont")
		end
		if disabled then
			item:SetDisabled(disabled)
		end
		item:SetIcon(icon)
		item:SetText(text)
		item.userdata.obj = self
		item.userdata.value = value
		item:SetCallback("OnValueChanged", OnItemValueChanged)
		self.pullout:AddItem(item)
	end
	
	local function AddCloseButton(self)
		if not self.hasClose then
			local close = AceGUI:Create("Dropdown-Item-Execute")
			close:SetText(CLOSE)
			self.pullout:AddItem(close)
			self.hasClose = true
		end
	end
	
	local sortlist = {}
	local function SetList(self, list)
		self.list = list
		self.pullout:Clear()
		self.hasClose = nil
		if not list then return end
		
		for v in pairs(list) do
			sortlist[#sortlist + 1] = v
		end
		table.sort(sortlist)
		
		for i, value in pairs(sortlist) do
			if type(list[value]) == "table" then
				AddListItem(self, list[value].value, list[value].text, list[value].icon, list[value].disabled)
			else
				AddListItem(self, value, list[value])
			end
			sortlist[i] = nil
		end
		if self.multiselect then
			ShowMultiText(self)
			AddCloseButton(self)
		end
	end
	
	local function SetMultiselect(self, multi)
		self.multiselect = multi
		if multi then
			ShowMultiText(self)
			AddCloseButton(self)
		end
	end
	
	local function SetItemValue(self, item, value)
		if not self.multiselect then return end
		for i, widget in self.pullout:IterateItems() do
			if widget.userdata.value == item then
				if widget.SetValue then
					widget:SetValue(value)
				end
			end
		end
		ShowMultiText(self)
	end	
	
	local function Constructor()
		local self = AceGUI:Create("Dropdown")
		self.type = widgetType

		self.OnAcquire = OnAcquire
		
		self.SetItemFont = SetItemFont
		self.SetFont = SetFont
		self.SetFontColor = SetFontColor
		self.SetItemFontColor = SetItemFontColor
		
		self.SetList = SetList
		self.AddListItem = AddListItem
		self.SetValue = SetValue
		self.SetMultiselect = SetMultiselect
		self.SetItemValue = SetItemValue
		
		AceGUI:RegisterAsWidget(self)
		return self
	end
	
	AceGUI:RegisterWidgetType(widgetType, Constructor, widgetVersion)
end	
