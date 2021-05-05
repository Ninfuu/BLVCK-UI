
AuraFramesDB = {
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
		},
	},
	["profileKeys"] = {
		["Ninfuu - Apollo 2"] = "Ninfuu - Apollo 2",
	},
	["profiles"] = {
		["Ninfuu - Apollo 2"] = {
			["Containers"] = {
				["PlayerDebuffs"] = {
					["Type"] = "ButtonContainer",
					["Id"] = "PlayerDebuffs",
					["Layout"] = {
						["DurationOutline"] = "OUTLINE",
						["SpaceY"] = 15,
						["Scale"] = 1,
						["DurationLayout"] = "ABBREVSPACE",
						["Clickable"] = true,
						["ShowTooltip"] = true,
						["HorizontalSize"] = 16,
						["MiniBarDirection"] = "HIGHSHRINK",
						["MiniBarColor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["CountColor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["MiniBarLength"] = 36,
						["DurationPosY"] = -25,
						["ButtonSizeX"] = 36,
						["CountOutline"] = "OUTLINE",
						["VerticalSize"] = 2,
						["Direction"] = "LEFTDOWN",
						["DurationSize"] = 11.10000038146973,
						["MiniBarTexture"] = "Blizzard",
						["MiniBarOffsetY"] = -25,
						["TooltipShowAuraId"] = false,
						["DurationPosX"] = 0,
						["CountMonochrome"] = false,
						["CountSize"] = 10,
						["DynamicSize"] = false,
						["MiniBarWidth"] = 8,
						["TooltipShowClassification"] = false,
						["DurationMonochrome"] = false,
						["MiniBarOffsetX"] = 0,
						["ButtonSizeY"] = 36,
						["TooltipShowPrefix"] = false,
						["CooldownDrawEdge"] = true,
						["MiniBarStyle"] = "HORIZONTAL",
						["ShowCooldown"] = false,
						["CooldownReverse"] = false,
						["DurationColor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["CountPosY"] = -6,
						["ShowCount"] = true,
						["ShowDuration"] = true,
						["CooldownDisableOmniCC"] = true,
						["CountFont"] = "Friz Quadrata TT",
						["TooltipShowCaster"] = true,
						["MiniBarEnabled"] = false,
						["DurationFont"] = "Myriad Condensed Web",
						["CountPosX"] = 10,
						["SpaceX"] = 5,
					},
					["Filter"] = {
						["Groups"] = {
						},
						["Expert"] = false,
					},
					["Sources"] = {
						["player"] = {
							["HARMFUL"] = true,
						},
					},
					["Colors"] = {
						["Expert"] = false,
						["DefaultColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["Rules"] = {
							{
								["Color"] = {
									0.8, -- [1]
									0, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["Name"] = "Unknown Debuff Type",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "HARMFUL",
											},
										}, -- [1]
										{
											["Operator"] = "Equal",
											["Subject"] = "Classification",
											["Args"] = {
												["String"] = "None",
											},
										}, -- [2]
									}, -- [1]
								},
							}, -- [1]
							{
								["Color"] = {
									0.2, -- [1]
									0.6, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["Name"] = "Debuff Type Magic",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "HARMFUL",
											},
										}, -- [1]
										{
											["Operator"] = "Equal",
											["Subject"] = "Classification",
											["Args"] = {
												["String"] = "Magic",
											},
										}, -- [2]
									}, -- [1]
								},
							}, -- [2]
							{
								["Color"] = {
									0.6, -- [1]
									0, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["Name"] = "Debuff Type Curse",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "HARMFUL",
											},
										}, -- [1]
										{
											["Operator"] = "Equal",
											["Subject"] = "Classification",
											["Args"] = {
												["String"] = "Curse",
											},
										}, -- [2]
									}, -- [1]
								},
							}, -- [3]
							{
								["Color"] = {
									0.6, -- [1]
									0.4, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["Name"] = "Debuff Type Disease",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "HARMFUL",
											},
										}, -- [1]
										{
											["Operator"] = "Equal",
											["Subject"] = "Classification",
											["Args"] = {
												["String"] = "Disease",
											},
										}, -- [2]
									}, -- [1]
								},
							}, -- [4]
							{
								["Color"] = {
									0, -- [1]
									0.6, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["Name"] = "Debuff Type Poison",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "HARMFUL",
											},
										}, -- [1]
										{
											["Operator"] = "Equal",
											["Subject"] = "Classification",
											["Args"] = {
												["String"] = "Poison",
											},
										}, -- [2]
									}, -- [1]
								},
							}, -- [5]
							{
								["Color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["Name"] = "Buff",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "HELPFUL",
											},
										}, -- [1]
									}, -- [1]
								},
							}, -- [6]
							{
								["Color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["Name"] = "Weapon",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "WEAPON",
											},
										}, -- [1]
									}, -- [1]
								},
							}, -- [7]
						},
					},
					["Warnings"] = {
						["Expire"] = {
							["FlashNumber"] = 5,
							["FlashSpeed"] = 1,
							["Flash"] = true,
						},
						["Changing"] = {
							["Popup"] = false,
							["PopupScale"] = 3,
							["PopupTime"] = 0.5,
						},
						["New"] = {
							["FlashNumber"] = 3,
							["FlashSpeed"] = 1,
							["Flash"] = false,
						},
					},
					["Location"] = {
						["OffsetX"] = -5.499515784150997,
						["OffsetY"] = -96.50000153871289,
						["FramePoint"] = "TOPRIGHT",
						["RelativePoint"] = "TOPRIGHT",
					},
					["Name"] = "Player Debuffs",
					["Visibility"] = {
						["OpacityNotVisible"] = 0,
						["FadeOut"] = true,
						["VisibleWhen"] = {
						},
						["FadeInTime"] = 0.5,
						["OpacityVisible"] = 1,
						["FadeOutTime"] = 0.5,
						["FadeIn"] = true,
						["AlwaysVisible"] = true,
					},
					["Order"] = {
						["Expert"] = false,
						["Predefined"] = "NoTimeTimeLeftDesc",
						["Rules"] = {
							{
								["Args"] = {
									["Float"] = 0,
								},
								["Subject"] = "ExpirationTime",
								["Operator"] = "First",
							}, -- [1]
							{
								["Args"] = {
								},
								["Subject"] = "ExpirationTime",
								["Operator"] = "NumberDesc",
							}, -- [2]
						},
					},
				},
				["Lines"] = {
					["Type"] = "BarContainer",
					["Id"] = "Lines",
					["Layout"] = {
						["TextureBackgroundUseTexture"] = true,
						["BarBorder"] = "Blizzard Tooltip",
						["TextureBackgroundColor"] = {
							0.3, -- [1]
							0.3, -- [2]
							0.3, -- [3]
							0.8, -- [4]
						},
						["Scale"] = 1,
						["BarUseAuraTime"] = false,
						["DurationLayout"] = "ABBREVSPACE",
						["TextMonochrome"] = false,
						["Clickable"] = true,
						["ShowTooltip"] = true,
						["TextureBackgroundUseBarColor"] = false,
						["BarTextureFlipY"] = false,
						["NumberOfBars"] = 5,
						["TextFont"] = "Myriad Condensed Web",
						["DynamicSize"] = false,
						["SparkUseBarColor"] = false,
						["BarBorderSize"] = 9,
						["TextOutline"] = "OUTLINE",
						["BarDirection"] = "LEFTSHRINK",
						["SparkColor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["BarTextureFlipX"] = false,
						["BarWidth"] = 230,
						["BarTextureInsets"] = 2,
						["Direction"] = "DOWN",
						["BarTextureMove"] = false,
						["BarBorderColorAdjust"] = 0,
						["BarHeight"] = 18,
						["ShowDuration"] = true,
						["CooldownDrawEdge"] = true,
						["HideSparkOnNoTime"] = true,
						["ShowCooldown"] = false,
						["Space"] = 0,
						["TextPosition"] = "LEFT",
						["TextSize"] = 14,
						["DurationPosition"] = "RIGHT",
						["TooltipShowPrefix"] = false,
						["ShowAuraName"] = true,
						["ShowSpark"] = true,
						["CooldownReverse"] = false,
						["BarMaxTime"] = 30,
						["BarTexture"] = "Minimalist",
						["BarTextureRotate"] = false,
						["ShowCount"] = true,
						["TooltipShowClassification"] = false,
						["CooldownDisableOmniCC"] = true,
						["TextureBackgroundOpacity"] = 0.5,
						["TooltipShowCaster"] = true,
						["TextColor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["Icon"] = "LEFT",
						["TooltipShowAuraId"] = false,
						["InverseOnNoTime"] = true,
					},
					["Filter"] = {
						["Groups"] = {
							{
								{
									["Operator"] = "NotEqual",
									["Subject"] = "SpellName",
									["Args"] = {
										["Float"] = 0,
										["SpellName"] = "Inner Fire",
									},
								}, -- [1]
								{
									["Operator"] = "LesserOrEqual",
									["Subject"] = "Duration",
									["Args"] = {
										["Float"] = 30,
									},
								}, -- [2]
							}, -- [1]
							{
							}, -- [2]
						},
						["Expert"] = true,
					},
					["Sources"] = {
						["player"] = {
							["HELPFUL"] = true,
						},
					},
					["Colors"] = {
						["Expert"] = false,
						["DefaultColor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["Rules"] = {
							{
								["Color"] = {
									0.8, -- [1]
									0, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["Name"] = "Unknown Debuff Type",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "HARMFUL",
											},
										}, -- [1]
										{
											["Operator"] = "Equal",
											["Subject"] = "Classification",
											["Args"] = {
												["String"] = "None",
											},
										}, -- [2]
									}, -- [1]
								},
							}, -- [1]
							{
								["Color"] = {
									0.2, -- [1]
									0.6, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["Name"] = "Debuff Type Magic",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "HARMFUL",
											},
										}, -- [1]
										{
											["Operator"] = "Equal",
											["Subject"] = "Classification",
											["Args"] = {
												["String"] = "Magic",
											},
										}, -- [2]
									}, -- [1]
								},
							}, -- [2]
							{
								["Color"] = {
									0.6, -- [1]
									0, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["Name"] = "Debuff Type Curse",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "HARMFUL",
											},
										}, -- [1]
										{
											["Operator"] = "Equal",
											["Subject"] = "Classification",
											["Args"] = {
												["String"] = "Curse",
											},
										}, -- [2]
									}, -- [1]
								},
							}, -- [3]
							{
								["Color"] = {
									0.6, -- [1]
									0.4, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["Name"] = "Debuff Type Disease",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "HARMFUL",
											},
										}, -- [1]
										{
											["Operator"] = "Equal",
											["Subject"] = "Classification",
											["Args"] = {
												["String"] = "Disease",
											},
										}, -- [2]
									}, -- [1]
								},
							}, -- [4]
							{
								["Color"] = {
									0, -- [1]
									0.6, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["Name"] = "Debuff Type Poison",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "HARMFUL",
											},
										}, -- [1]
										{
											["Operator"] = "Equal",
											["Subject"] = "Classification",
											["Args"] = {
												["String"] = "Poison",
											},
										}, -- [2]
									}, -- [1]
								},
							}, -- [5]
							{
								["Color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["Name"] = "Buff",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "HELPFUL",
											},
										}, -- [1]
									}, -- [1]
								},
							}, -- [6]
							{
								["Color"] = {
									1, -- [1]
									1, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["Name"] = "Weapon",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "WEAPON",
											},
										}, -- [1]
									}, -- [1]
								},
							}, -- [7]
						},
					},
					["Warnings"] = {
						["Expire"] = {
							["FlashNumber"] = 5,
							["FlashSpeed"] = 1,
							["Flash"] = false,
						},
						["Changing"] = {
							["Popup"] = false,
							["PopupScale"] = 3,
							["PopupTime"] = 0.5,
						},
						["New"] = {
							["FlashNumber"] = 3,
							["FlashSpeed"] = 1,
							["Flash"] = false,
						},
					},
					["Location"] = {
						["OffsetX"] = -294.0001607100127,
						["OffsetY"] = 28.00009492148837,
						["FramePoint"] = "BOTTOM",
						["RelativePoint"] = "BOTTOM",
					},
					["Name"] = "Lines",
					["Visibility"] = {
						["OpacityNotVisible"] = 0,
						["FadeOut"] = true,
						["VisibleWhen"] = {
						},
						["FadeInTime"] = 0.5,
						["OpacityVisible"] = 1,
						["FadeOutTime"] = 0.5,
						["FadeIn"] = true,
						["AlwaysVisible"] = true,
					},
					["Order"] = {
						["Expert"] = false,
						["Predefined"] = "NoTimeTimeLeftDesc",
						["Rules"] = {
							{
								["Args"] = {
									["Float"] = 0,
								},
								["Subject"] = "ExpirationTime",
								["Operator"] = "First",
							}, -- [1]
							{
								["Args"] = {
								},
								["Subject"] = "ExpirationTime",
								["Operator"] = "NumberDesc",
							}, -- [2]
						},
					},
				},
				["PlayerBuffs"] = {
					["Type"] = "ButtonContainer",
					["Id"] = "PlayerBuffs",
					["Layout"] = {
						["DurationOutline"] = "OUTLINE",
						["SpaceY"] = 15.00000095367432,
						["Scale"] = 1,
						["DurationLayout"] = "ABBREVSPACE",
						["Clickable"] = true,
						["ShowTooltip"] = true,
						["HorizontalSize"] = 16,
						["MiniBarDirection"] = "HIGHSHRINK",
						["MiniBarColor"] = {
							0, -- [1]
							1, -- [2]
							0.8509803921568627, -- [3]
							1, -- [4]
						},
						["CountColor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["MiniBarLength"] = 36,
						["DurationPosY"] = -25,
						["ButtonSizeX"] = 36,
						["CountOutline"] = "OUTLINE",
						["VerticalSize"] = 2,
						["Direction"] = "LEFTDOWN",
						["DurationSize"] = 11.10000038146973,
						["MiniBarTexture"] = "Graphite",
						["MiniBarOffsetY"] = -27,
						["TooltipShowAuraId"] = false,
						["DurationPosX"] = 0,
						["CountMonochrome"] = false,
						["CountSize"] = 10,
						["DynamicSize"] = false,
						["MiniBarWidth"] = 10,
						["TooltipShowClassification"] = false,
						["DurationMonochrome"] = false,
						["MiniBarOffsetX"] = 0,
						["ButtonSizeY"] = 36,
						["TooltipShowPrefix"] = false,
						["CooldownDrawEdge"] = true,
						["MiniBarStyle"] = "HORIZONTAL",
						["ShowCooldown"] = false,
						["CooldownReverse"] = false,
						["DurationColor"] = {
							1, -- [1]
							1, -- [2]
							1, -- [3]
							1, -- [4]
						},
						["CountPosY"] = -6,
						["ShowCount"] = true,
						["ShowDuration"] = true,
						["CooldownDisableOmniCC"] = true,
						["CountFont"] = "Friz Quadrata TT",
						["TooltipShowCaster"] = true,
						["MiniBarEnabled"] = false,
						["DurationFont"] = "Myriad Condensed Web",
						["CountPosX"] = 10,
						["SpaceX"] = 8.500000953674316,
					},
					["Filter"] = {
						["Groups"] = {
							{
								{
									["Operator"] = "GreaterOrEqual",
									["Subject"] = "Duration",
									["Args"] = {
										["Float"] = 30,
										["String"] = "Poison",
									},
								}, -- [1]
							}, -- [1]
							{
								{
									["Operator"] = "Equal",
									["Subject"] = "Duration",
									["Args"] = {
										["Float"] = 0,
									},
								}, -- [1]
							}, -- [2]
						},
						["Expert"] = true,
					},
					["Sources"] = {
						["player"] = {
							["WEAPON"] = true,
							["HELPFUL"] = true,
						},
					},
					["Colors"] = {
						["Expert"] = false,
						["DefaultColor"] = {
							0, -- [1]
							0, -- [2]
							0, -- [3]
							1, -- [4]
						},
						["Rules"] = {
							{
								["Color"] = {
									0.8, -- [1]
									0, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["Name"] = "Unknown Debuff Type",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "HARMFUL",
											},
										}, -- [1]
										{
											["Operator"] = "Equal",
											["Subject"] = "Classification",
											["Args"] = {
												["String"] = "None",
											},
										}, -- [2]
									}, -- [1]
								},
							}, -- [1]
							{
								["Color"] = {
									0.2, -- [1]
									0.6, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["Name"] = "Debuff Type Magic",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "HARMFUL",
											},
										}, -- [1]
										{
											["Operator"] = "Equal",
											["Subject"] = "Classification",
											["Args"] = {
												["String"] = "Magic",
											},
										}, -- [2]
									}, -- [1]
								},
							}, -- [2]
							{
								["Color"] = {
									0.6, -- [1]
									0, -- [2]
									1, -- [3]
									1, -- [4]
								},
								["Name"] = "Debuff Type Curse",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "HARMFUL",
											},
										}, -- [1]
										{
											["Operator"] = "Equal",
											["Subject"] = "Classification",
											["Args"] = {
												["String"] = "Curse",
											},
										}, -- [2]
									}, -- [1]
								},
							}, -- [3]
							{
								["Color"] = {
									0.6, -- [1]
									0.4, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["Name"] = "Debuff Type Disease",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "HARMFUL",
											},
										}, -- [1]
										{
											["Operator"] = "Equal",
											["Subject"] = "Classification",
											["Args"] = {
												["String"] = "Disease",
											},
										}, -- [2]
									}, -- [1]
								},
							}, -- [4]
							{
								["Color"] = {
									0, -- [1]
									0.6, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["Name"] = "Debuff Type Poison",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "HARMFUL",
											},
										}, -- [1]
										{
											["Operator"] = "Equal",
											["Subject"] = "Classification",
											["Args"] = {
												["String"] = "Poison",
											},
										}, -- [2]
									}, -- [1]
								},
							}, -- [5]
							{
								["Color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["Name"] = "Buff",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "HELPFUL",
											},
										}, -- [1]
									}, -- [1]
								},
							}, -- [6]
							{
								["Color"] = {
									0, -- [1]
									0, -- [2]
									0, -- [3]
									1, -- [4]
								},
								["Name"] = "Weapon",
								["Groups"] = {
									{
										{
											["Operator"] = "Equal",
											["Subject"] = "Type",
											["Args"] = {
												["String"] = "WEAPON",
											},
										}, -- [1]
									}, -- [1]
								},
							}, -- [7]
						},
					},
					["Warnings"] = {
						["Expire"] = {
							["FlashNumber"] = 5,
							["FlashSpeed"] = 1,
							["Flash"] = true,
						},
						["Changing"] = {
							["Popup"] = false,
							["PopupScale"] = 3,
							["PopupTime"] = 0.5,
						},
						["New"] = {
							["FlashNumber"] = 3,
							["FlashSpeed"] = 1,
							["Flash"] = false,
						},
					},
					["Location"] = {
						["OffsetX"] = -5.499647087650763,
						["OffsetY"] = -5.499975346400174,
						["FramePoint"] = "TOPRIGHT",
						["RelativePoint"] = "TOPRIGHT",
					},
					["Name"] = "Player Buffs",
					["Visibility"] = {
						["OpacityNotVisible"] = 0,
						["FadeOut"] = true,
						["VisibleWhen"] = {
						},
						["FadeInTime"] = 0.5,
						["OpacityVisible"] = 1,
						["FadeOutTime"] = 0.5,
						["FadeIn"] = true,
						["AlwaysVisible"] = true,
					},
					["Order"] = {
						["Expert"] = false,
						["Predefined"] = "NoTimeTimeLeftDesc",
						["Rules"] = {
							{
								["Args"] = {
									["Float"] = 0,
								},
								["Subject"] = "ExpirationTime",
								["Operator"] = "First",
							}, -- [1]
							{
								["Args"] = {
								},
								["Subject"] = "ExpirationTime",
								["Operator"] = "NumberDesc",
							}, -- [2]
						},
					},
				},
			},
			["DbVersion"] = 222,
		},
	},
}
