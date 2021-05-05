local mNameplates = mNameplates

local Nameplates = LibStub("LibNameplate-1.0")

do
	local OnUpdateFuncs = {}
	local FuncElapsed = {}
	local UpdateFrame = CreateFrame("Frame")
	UpdateFrame:SetScript("OnUpdate", function(self, elapsed)
		for module, functions in pairs(OnUpdateFuncs) do
			for func, data in pairs(functions) do
				if data.updateRate then
					data.elapsed = data.elapsed + elapsed
					if data.elapsed > data.updateRate then
						func(module, data.elapsed)
						data.elapsed = 0
					end
				else
					func(module, elapsed)
				end
			end
		end
	end)	
	
	function mNameplates:RegisterOnUpdate(module, func, updateRate)
		assert(module and func, "Usage: RegisterOnUpdate(module, func)")
		OnUpdateFuncs[module] = OnUpdateFuncs[module] or {}
		OnUpdateFuncs[module][func] = {updateRate = updateRate, elapsed = 0}
	end
	
	function mNameplates:UnregisterOnUpdate(module, func)
		assert(module and func, "Usage: UnregisterOnUpdate(module, func")
		if OnUpdateFuncs[module] then
			OnUpdateFuncs[module][func] = nil
		end
	end
	
	function mNameplates:MouseOverUpdate()
		self = mNameplates
		local plate = Nameplates:GetNameplateByUnit("mouseover")
		if self.CurrentMouseOver and self.CurrentMouseOver ~= plate then
			self.Callbacks:Fire("PlateMouseLeave", self.CurrentMouseOver, self:GetExtra(self.CurrentMouseOver))
			local data = self:GetExtra(self.CurrentMouseOver)
			if data then 
				for i, frame in pairs(data) do 
					frame:SetFrameLevel(frame:GetFrameLevel() - 100)
				end
			end
			self.CurrentMouseOver = nil
			self:UnregisterOnUpdate(self, self.MouseOverUpdate)
		end
	end
end

function mNameplates:CondensedNumber(value)
	assert(value and type(value) == "number", "Usage CondensedNumber(number)")
	local result

	if value > 10000000 then
	   result = ("%.fm"):format(value/1000000)
	elseif value > 1000000 then
	   result = ("%.2fm"):format(value/1000000)
	elseif value > 100000 then
	   result = ("%.0fk"):format(value/1000)
	elseif value > 1000 then
	   result = ("%.1fk"):format(value/1000)
	end
	
	return result or value
end