local AceGUI = LibStub("AceGUI-3.0")

-- WoW APIs
local CreateFrame, UIParent = CreateFrame, UIParent

-- Global vars/functions that we don't upvalue since they might get hooked, or upgraded
-- List them here for Mikk's FindGlobals script
-- GLOBALS: ShowUIPanel, HideUIPanel, ColorPickerFrame, OpacitySliderFrame

--------------------------
-- ColorPicker		  --
--------------------------
do
	local Type = "UIF-ColorPicker"
	local Version = 3
	
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

	local function Constructor()
		local self = AceGUI:Create("ColorPicker")
		self.type = Type
		
		self.oldSetDisable = self.SetDisabled
		self.SetDisabled = SetDisabled
		
		self.SetFont = SetFont
		self.SetFontColor = SetFontColor
		
		return self
	end
	
	AceGUI:RegisterWidgetType(Type,Constructor,Version)
end
