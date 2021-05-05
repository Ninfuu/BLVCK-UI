local AceGUI = LibStub("AceGUI-3.0")


--------------------------
-- Check Box			--
--------------------------
--[[
	Events :
		OnValueChanged

]]
do
	local Type = "UIF-CheckBox"
	local Version = 4
	
	local function SetFont(self, font, size, flags)
		self.text:SetFont(font, size, flags)
	end
	
	local function SetFontColor(self, color)
		self.newColor = color
		self.text:SetTextColor(unpack(color))
	end
	
	local function SetDisabled(self, disabled)
		self.oldSetDisable(self, disabled)
		if not disabled and self.newColor then
			self.text:SetTextColor(unpack(self.newColor))
		end
	end
	
	local function SetValue(self, value)
		self.oldSetValue(self, value)
		SetDisabled(self, self.disabled)
	end
	
	local function Constructor()
		local self = AceGUI:Create("CheckBox")
		self.type = Type
		
		self.oldSetDisable = self.SetDisabled
		self.oldSetValue = self.SetValue
		self.SetDisabled = SetDisabled
		self.SetValue = SetValue
		
		self.SetFont = SetFont
		self.SetFontColor = SetFontColor
		return self
	end
	
	AceGUI:RegisterWidgetType(Type,Constructor,Version)
end
