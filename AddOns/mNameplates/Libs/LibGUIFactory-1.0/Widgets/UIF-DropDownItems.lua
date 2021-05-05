local AceGUI = LibStub("AceGUI-3.0")

do
	local widgetType = "UIFDropdown-Item-Toggle"
	local widgetVersion = 5
	
	local function SetFont(self, font)
		if _G[font] and _G[font].GetFont then
			self.text:SetFontObject(font)
			self.text:SetTextColor(_G[font]:GetTextColor())
			local fontHeight = select(2, _G[font]:GetFont())
			if fontHeight > self.frame:GetHeight() then
				self.frame:SetHeight(fontHeight + 4)
				self.highlight:SetHeight(fontHeight)
			end
		end
	end
	
	local function SetIcon(self, icon)
		self.icon:SetTexture(icon)
		if self.icon:GetTexture() then
			self.icon:Show()
			self.icon:SetWidth(self.frame:GetHeight() - 4)
		else
			self.icon:SetWidth(1)
			self.icon:Hide()
		end
	end
	
	local function Constructor()
		local self = AceGUI:Create("Dropdown-Item-Toggle")		
		self.type = widgetType
		
		local icon = self.frame:CreateTexture(nil, "OVERLAY")
		icon:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 18, -2)
		icon:SetPoint("BOTTOMLEFT", self.frame, "BOTTOMLEFT", 18, 2 )		
		icon:Hide()		
		icon:SetWidth(1)
		icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
		self.icon = icon
		
		self.check:SetPoint("LEFT", icon, "RIGHT", 2, 0)
		self.text:SetPoint("TOPLEFT", self.check, "TOPRIGHT", 2, 0)
		
		self.SetFont	= SetFont
		self.SetIcon	= SetIcon
		
		AceGUI:RegisterAsWidget(self)
		return self
	end
	
	AceGUI:RegisterWidgetType(widgetType, Constructor, widgetVersion)
end


