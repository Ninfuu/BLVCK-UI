local mNameplates = LibStub("AceAddon-3.0"):GetAddon("mNameplates")
if not mNameplates then return end

local plugin = mNameplates:NewFilterModule("NameFilter")
plugin.DisplayName = "Name Filter"

local AceGUI 	= LibStub("AceGUI-3.0")
local Nameplates = LibStub("LibNameplate-1.0")
local UIF
local db


local defaults = {
	profile = {
		Enabled = true,
		
		Categories = {
			["**"] = {
				Enabled = true,
				Names = {
				},
			},
			Default = {
			}
		}
	}
}

function plugin:OnInitialize()
	self.db = mNameplates.db:RegisterNamespace(self:GetName(), defaults)
	db = self.db.profile
	
	self.db.RegisterCallback(self, "OnProfileChanged", "ProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "ProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "ProfileChanged")	
	
	self:SetEnabledState(db.Enabled)
	
	UIF = LibStub("LibGUIFactory-1.0"):GetFactory("mNameplates")	
end

function plugin:OnEnable()
end

function plugin:OnDisable()
end

function plugin:ProfileChanged(event)
	db = self.db.profile
	if db.Enabled then
		if not self:IsEnabled() then self:Enable() end
	elseif not db.Enabled and self:IsEnabled() then 
		self:Disable()
	end	
end

-- ~~~~~~~~~~~~~~~~~~
-- Filter ~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~
function plugin:RunFilter(plate)
	if not self:IsEnabled() then return end
	
	local plateName = Nameplates:GetName(plate)
	
	for categoryName, category in pairs(db.Categories) do
		if category.Enabled then
			for name, enabled in pairs(category.Names) do
				if plateName == name and enabled then
					return true
				end
			end
		end
	end
end

-- ~~~~~~~~~~~~~~~~~~~~~~
-- Options ~~~~~~~~~~~~~~
-- ~~~~~~~~~~~~~~~~~~~~~~
do
	local function Callback()
		mNameplates:FilterChanged()
	end
	
	local NameList = {}
	local function GetNameList(category)
		wipe(NameList)
		for name in pairs(category.Names) do
			NameList[name] = name
		end
		return NameList
	end
	
	local CategoryList = {}
	local function GetCategoryList()
		wipe(CategoryList)
		for categoryName in pairs(db.Categories) do
			CategoryList[categoryName] = categoryName
		end
		return CategoryList
	end
	
	local function DeleteNameCallback(widget, event, name)
		db.Names[name] = nil
		Callback()
		mNameplates:ToggleConfig(true)
	end
	
	local options
	function plugin:GetOptions()
		if options then return options end
		options = {
			{
				data = {{text = plugin.DisplayName, value = plugin.DisplayName}},
				func = function()
					local g = AceGUI:Create("SimpleGroup")
					g:SetLayout("Flow")
					g:SetFullWidth(true)										
					
					g:AddChild(UIF:CheckBox("Enabled", db, "Enabled", function() 
						if db.Enabled and not plugin:IsEnabled() then plugin:Enable()
						elseif not db.Enabled and plugin:IsEnabled() then plugin:Disable() end
					end))
					
					local ed = AceGUI:Create("EditBox")
					ed:SetLabel("Add New Category")
					ed:SetCallback("OnEnterPressed", function(self, event, text)
						self.editbox:ClearFocus()
						local t = db.Categories[text]
						mNameplates:ToggleConfig(true)
					end)
					ed:SetRelativeWidth(0.4)
					g:AddChild(ed)
					
					g:AddChild(UIF:SimpleDropdown("Delete Category", function(widget, event, category)
						db.Categories[category] = nil
						Callback()
						mNameplates:ToggleConfig(true)
					end, GetCategoryList(), 0.4))
				
					for categoryName, category in pairs(db.Categories) do
						local group = UIF:InlineGroup1(categoryName)
						g:AddChild(group)
						
						group:AddChild(UIF:CheckBox("Enabled", category, "Enabled", Callback))
						
						local ed = AceGUI:Create("EditBox")
						ed:SetLabel("Add Name")
						ed:SetCallback("OnEnterPressed", function(self, event, text)
							self.editbox:ClearFocus()
							category.Names[text] = true
							Callback()
							mNameplates:ToggleConfig(true)
						end)
						ed:SetRelativeWidth(0.4)
						group:AddChild(ed)
						
						group:AddChild(UIF:SimpleDropdown("Delete name", function(widget, event, name)
							category.Names[name] = nil
							Callback()
							mNameplates:ToggleConfig(true)
						end, GetNameList(category), 0.4))
						group:AddChild(UIF:Button("Add target", function()
							local name = UnitName("target")
							if not name then return end
							category.Names[name] = true
							Callback()
							mNameplates:ToggleConfig(true)
						end))
						
						group:AddChild(UIF:NewLine())
						for name in pairs(category.Names) do
							group:AddChild(UIF:CheckBox(name, category.Names, name, Callback, nil, 0.25))
						end
					end
					
					
					
					return g
				end
			}
		}
		return options
	end
end