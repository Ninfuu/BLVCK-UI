local AceGUI = LibStub("AceGUI-3.0")

do
	local Type = "UIF-TabGroup"
	local Version = 3
	
	local function SetFont(self, font, size, flags)
		self.titletext:SetFont(font, size, flags)
	end
	
	local function SetFontColor(self, color)
		self.titletext:SetTextColor(unpack(color))
	end
	
	local function SetBorderColor(self, color)
		self.border:SetBackdropBorderColor(unpack(color))	
	end
	
	local function SetBackColor(self, color)
		self.border:SetBackdropColor(unpack(color))	
	end	

	local function Constructor()
		local self = AceGUI:Create("TabGroup")
		self.type = Type
		
		self.SetBorderColor = SetBorderColor
		self.SetBackColor = SetBackColor
		self.SetFont = SetFont
		self.SetFontColor = SetFontColor
		
		
		self.border:ClearAllPoints()
		self.border:SetPoint("TOPLEFT",self.titletext,"TOPLEFT",1,0)
		self.border:SetPoint("BOTTOMRIGHT",self.frame,"BOTTOMRIGHT",-1,3)
		
		return self
	end
	
	AceGUI:RegisterWidgetType(Type,Constructor,Version)
end
