local AceGUI = LibStub("AceGUI-3.0")


do
	local Type = "UIF-Label"
	local Version = 2

	local function OnRelease(self)
		self.background:Hide()
	end
	
	local function SetBackground(self, color)
		self.background:SetTexture(unpack(color))
		self.background:Show()
	end
	
	local function Constructor()
		local self = AceGUI:Create("Label")
		self.type = Type
		
		local frame = CreateFrame("Frame", nil, UIParent)
		frame:Hide()
		
		local t = frame:CreateTexture(nil, "BACKGROUND")
		t:SetAllPoints()
		t:Hide()
		self.background = t
		
		self.frame:SetParent(frame)
		self.frame:Show()
		self.frame:ClearAllPoints()
		self.frame:SetAllPoints()
		self.textframe = self.frame
		self.frame = frame
		
		self.label:SetJustifyV("MIDDLE")
		
		self.SetBackground = SetBackground
		self.OnRelease = OnRelease
				
		AceGUI:RegisterAsWidget(self)
		return self
	end
	
	AceGUI:RegisterWidgetType(Type,Constructor,Version)
end
