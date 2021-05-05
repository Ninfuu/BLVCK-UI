local AceGUI = LibStub("AceGUI-3.0")

-- WoW APIs
local _G = _G
local CreateFrame, UIParent = CreateFrame, UIParent

--------------------------
-- Button		        --
--------------------------
do
	local Type = "UIF-Button"
	local Version = 3
	
	local function SetFont(self, font, fontSize, flags)
		self.text:SetFont(font, fontSize, flags)
	end
	
	local function SetFontColor(self, color)
		self.text:SetTextColor(unpack(color))
	end
	
	local function Constructor()
		local self = AceGUI:Create("Button")
		self.type = Type
		
		self.SetFont = SetFont
		self.SetFontColor = SetFontColor
		
		return self
	end
	
	AceGUI:RegisterWidgetType(Type,Constructor,Version)
end
