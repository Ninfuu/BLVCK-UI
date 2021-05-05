local AceGUI = LibStub("AceGUI-3.0")

-- Lua APIs
local min, max, floor = math.min, math.max, math.floor
local tonumber = tonumber

-- WoW APIs
local CreateFrame, UIParent = CreateFrame, UIParent

-- Global vars/functions that we don't upvalue since they might get hooked, or upgraded
-- List them here for Mikk's FindGlobals script
-- GLOBALS: GameFontHighlightSmall

--------------------------
-- Slider  	            --
--------------------------
do
	local Type = "UIF-Slider"
	local Version = 3
	
	local function SetDisabled(self, disabled)
		self.oldSetDisable(self, disabled)
		if not disabled and self.newColor then
			self.label:SetTextColor(unpack(self.newColor))
		self.lowtext:SetTextColor(unpack(self.newColor))
		self.hightext:SetTextColor(unpack(self.newColor))
		end
	end
	
	local function SetFont(self, font, size, flags)
		self.label:SetFont(font, size, flags)
		self.lowtext:SetFont(font, size, flags)
		self.hightext:SetFont(font, size, flags)
		self.editbox:SetFont(font, size, "none")
	end
	
	local function SetFontColor(self, color)
		self.newColor = color
		self.label:SetTextColor(unpack(color))
		self.lowtext:SetTextColor(unpack(color))
		self.hightext:SetTextColor(unpack(color))
	end	
	
	local function Constructor()
		local self = AceGUI:Create("Slider")
		self.type = Type
		
		self.oldSetDisable = self.SetDisabled
		self.SetDisabled = SetDisabled

		self.SetFont = SetFont
		self.SetFontColor = SetFontColor
		
		return self
	end
	
	AceGUI:RegisterWidgetType(Type,Constructor,Version)
end
