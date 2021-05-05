local AceGUI = LibStub("AceGUI-3.0")


do
	local Type = "UIF-NewLine"
	local Version = 1
	
	local function OnAcquire(sefl)
	end
	
	local function OnRelease(self)
	end
	
	local function Constructor()
		local frame = CreateFrame("Frame")
		self = {}
		self.type = Type
		self.frame = frame
		
		self.OnAcquire = OnAcquire
		self.OnRelease = OnRelease
				
		AceGUI:RegisterAsWidget(self)
		return self
	end
	
	AceGUI:RegisterWidgetType(Type,Constructor,Version)
end
