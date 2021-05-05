--[[
Copyright 2011 João Libório Cardoso
Bagnon Facade is distributed under the terms of the GNU General Public License (or the Lesser GPL).
This file is part of Bagnon Facade.

Bagnon Facade is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Bagnon Facade is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Bagnon Facade. If not, see <http://www.gnu.org/licenses/>.
--]]

local Facade = LibStub('LibButtonFacade')
local Addon = LibStub('AceAddon-3.0'):NewAddon('Bagnon Facade')


--[[ API ]]--

function Addon:OnInitialize()
	BagnonFacade_Settings = BagnonFacade_Settings or {}
	Facade:RegisterSkinCallback('Bagnon', self.OnSkinChanged, self)
		
	local enabled, loadable = select(4, GetAddOnInfo('Bagnon_GuildBank'))
	if enabled and loadable then
		self:NewGroup('guildbank')
	end
	
	self:NewGroup('inventory')
	self:NewGroup('bank')
end

function Addon:NewGroup(name)
	Facade:Group('Bagnon', name):Skin(unpack(BagnonFacade_Settings[name] or BagnonFacade_Settings.default or {}))
end

function Addon:OnSkinChanged(skin, glossAlpha, gloss, group, _, colors)
	group = group or 'default'
	BagnonFacade_Settings[group] = {skin, glossAlpha, gloss, colors}
end


--[[ ItemFrame Hacks ]]--

local ItemFrame = Bagnon.ItemFrame
local LayoutFrame = ItemFrame.Layout

function ItemFrame:Layout()
	LayoutFrame(self)
	
	local group = Facade:Group('Bagnon', self:GetFrameID())
	if group then
		group:ReSkin()
	end
end


--[[ ItemSlot Hacks ]]--

local ItemSlot = Bagnon.ItemSlot
local NewSlot = ItemSlot.New
local FreeSlot = ItemSlot.Free

function ItemSlot:New(...)
	local item = NewSlot(self, ...)
	local name = item:GetName()
		
	Facade:Group('Bagnon', item:GetFrameID()):AddButton(item, {
		Count = _G[name .. 'Count'],
		Icon = _G[name .. 'IconTexture'],
		Normal = _G[name .. 'NormalTexture'],
		
		Highlight = item:GetHighlightTexture(),
		Pushed = item:GetPushedTexture(),
		
		Cooldown = item.cooldown,
		Border = item.border,
		
		AutoCastable = false, AutoCast = false,
		HotKey = false, Name = false, Duration = false,
		Disabled = false, Checked = false,
		Flash = false,
	})
	
	return item
end

function ItemSlot:Free()
	FreeSlot(self)
	Facade:Group('Bagnon', self:GetFrameID()):RemoveButton(self, true)
end