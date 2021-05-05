local _NAME, _NS = ...
local Butsu = _G[_NAME]

do
	local slots = {}
	_NS.slots = slots

	local OnEnter = function(self)
		local slot = self:GetID()
		if(LootSlotIsItem(slot)) then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetLootItem(slot)
			CursorUpdate(self)
		end

		self.drop:Show()
		self.drop:SetVertexColor(1, 1, 0)
	end

	local OnLeave = function(self)
		if(self.quality > 1) then
			local color = ITEM_QUALITY_COLORS[self.quality]
			self.drop:SetVertexColor(color.r, color.g, color.b)
		else
			self.drop:Hide()
		end

		GameTooltip:Hide()
		ResetCursor()
	end

	local OnClick = function(self)
		if(IsModifiedClick()) then
			HandleModifiedItemClick(GetLootSlotLink(self:GetID()))
		else
			StaticPopup_Hide"CONFIRM_LOOT_DISTRIBUTION"

			LootFrame.selectedLootButton = self
			LootFrame.selectedSlot = self:GetID()
			LootFrame.selectedQuality = self.quality
			LootFrame.selectedItemName = self.name:GetText()

			LootSlot(self:GetID())
		end
	end

	local OnUpdate = function(self)
		if(GameTooltip:IsOwned(self)) then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetLootItem(self:GetID())
			CursorOnUpdate(self)
		end
	end

	function _NS.CreateSlot(id)
		local db = _NS.db

		local iconSize = db.iconSize
		local fontSizeItem = db.fontSizeItem
		local fontSizeCount = db.fontSizeCount
		local fontItem = GameFontWhite:GetFont()
		local fontCount = NumberFontNormalSmall:GetFont()

		local frame = CreateFrame("Button", 'ButsuSlot'..id, Butsu)
		frame:SetHeight(math.max(fontSizeItem, iconSize))
		frame:SetID(id)

		frame:RegisterForClicks("LeftButtonUp", "RightButtonUp")

		frame:SetScript("OnEnter", OnEnter)
		frame:SetScript("OnLeave", OnLeave)
		frame:SetScript("OnClick", OnClick)
		frame:SetScript("OnUpdate", OnUpdate)

		local iconFrame = CreateFrame("Frame", nil, frame)
		iconFrame:SetSize(iconSize, iconSize)
		iconFrame:SetPoint("RIGHT", frame)
		frame.iconFrame = iconFrame

		local icon = iconFrame:CreateTexture(nil, "ARTWORK")
		icon:SetAlpha(.8)
		icon:SetTexCoord(.07, .93, .07, .93)
		icon:SetAllPoints(iconFrame)
		frame.icon = icon

		local count = iconFrame:CreateFontString(nil, "OVERLAY")
		count:SetJustifyH"RIGHT"
		count:SetPoint("BOTTOMRIGHT", iconFrame, 2, 2)
		count:SetFont(fontCount, fontSizeCount, 'OUTLINE')
		count:SetShadowOffset(.8, -.8)
		count:SetShadowColor(0, 0, 0, 1)
		count:SetText(1)
		frame.count = count

		local name = frame:CreateFontString(nil, "OVERLAY")
		name:SetJustifyH"LEFT"
		name:SetPoint("LEFT", frame)
		name:SetPoint("RIGHT", iconFrame, "LEFT")
		name:SetNonSpaceWrap(true)
		name:SetFont(fontItem, fontSizeItem)
		name:SetShadowOffset(.8, -.8)
		name:SetShadowColor(0, 0, 0, 1)
		frame.name = name

		local drop = frame:CreateTexture(nil, "ARTWORK")
		drop:SetTexture[[Interface\AddOns\\Butsu\\Textures\\BLVCK.tga]]

		drop:SetPoint("LEFT", icon, "RIGHT")
		drop:SetPoint("RIGHT", frame)
		drop:SetAllPoints(frame)
		drop:SetAlpha(.3)
		frame.drop = drop

		slots[id] = frame
		return frame
	end

	function Butsu:UpdateWidth()
		local maxWidth = 0
		for _, slot in next, _NS.slots do
			local width = slot.name:GetStringWidth()
			if(width > maxWidth) then
				maxWidth = width
			end
		end

		self:SetWidth(math.max(maxWidth + 30 + _NS.db.iconSize))

	end

	function Butsu:AnchorSlots()
		local frameSize = math.max(_NS.db.iconSize, _NS.db.fontSizeItem)
		local iconSize = _NS.db.iconSize
		local shownSlots = 0

		local prevShown
		for i=1, #slots do
			local frame = slots[i]
			if(frame:IsShown()) then
				frame:ClearAllPoints()
				frame:SetPoint("LEFT", 8, 0)
				frame:SetPoint("RIGHT", -8, 0)
				if(not prevShown) then
					frame:SetPoint('TOPLEFT', self, 8, -8)
				else
					frame:SetPoint('TOP', prevShown, 'BOTTOM')
				end

				frame:SetHeight(frameSize)
				shownSlots = shownSlots + 1
				prevShown = frame
			end
		end

		local offset = self:GetTop() or 0
		self:SetHeight(math.max((shownSlots * frameSize + 16), 20))

		-- Reposition the frame so it doesn't move.
		local point, parent, relPoint, x, y = self:GetPoint()
		offset = offset - (self:GetTop() or 0)
		self:SetPoint(point, parent, relPoint, x, y + offset)
	end
end
