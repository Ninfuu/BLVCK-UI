
ElvDB = {
	["gold"] = {
		["Apollo 2"] = {
			["Ninfuu"] = 14835,
		},
	},
	["global"] = {
		["general"] = {
			["AceGUI"] = {
				["height"] = 728,
			},
		},
		["nameplates"] = {
			["filters"] = {
				["ElvUI_NonTarget"] = {
				},
				["ElvUI_Totem"] = {
				},
				["ElvUI_Target"] = {
				},
				["ElvUI_Boss"] = {
				},
			},
		},
	},
	["faction"] = {
		["Apollo 2"] = {
			["Ninfuu"] = "Alliance",
		},
	},
	["namespaces"] = {
		["LibDualSpec-1.0"] = {
		},
	},
	["class"] = {
		["Apollo 2"] = {
			["Ninfuu"] = "PRIEST",
		},
	},
	["profileKeys"] = {
		["Ninfuu - Apollo 2"] = "Ninfuu - Apollo 2",
	},
	["profiles"] = {
		["Ninfuu - Apollo 2"] = {
			["databars"] = {
				["experience"] = {
					["width"] = 350,
					["orientation"] = "HORIZONTAL",
					["textSize"] = 12,
					["height"] = 10,
				},
				["reputation"] = {
					["enable"] = true,
					["width"] = 222,
					["height"] = 10,
					["orientation"] = "HORIZONTAL",
				},
			},
			["currentTutorial"] = 1,
			["bags"] = {
				["bagSize"] = 42,
				["bankSize"] = 42,
				["bagWidth"] = 472,
				["bankWidth"] = 472,
			},
			["hideTutorial"] = 1,
			["chat"] = {
				["panelWidth"] = 472,
				["panelHeight"] = 236,
			},
			["layoutSet"] = "dpsCaster",
			["layoutSetting"] = "dpsCaster",
			["tooltip"] = {
				["healthBar"] = {
					["fontOutline"] = "MONOCHROMEOUTLINE",
					["height"] = 12,
				},
			},
			["movers"] = {
				["ElvUF_Raid40Mover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,482",
				["MirrorTimer1Mover"] = "TOP,ElvUIParent,TOP,-1,-96",
				["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,1,183",
				["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,1,131",
				["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,4",
				["ElvUF_TargetTargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-498,84",
				["LootFrameMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,418,-186",
				["ExperienceBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,43",
				["RightChatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-4,4",
				["AltPowerBarMover"] = "TOP,ElvUIParent,TOP,-1,-36",
				["BossButton"] = "BOTTOM,ElvUIParent,BOTTOM,-1,293",
				["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,-92,57",
				["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-285,84",
				["TempEnchantMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-4,-257",
				["WatchFrameMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-163,-325",
				["TotemBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-474,-462",
				["BNETMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-4,-274",
				["ShiftAB"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,769",
				["ReputationBarMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-4,-246",
				["ElvUF_FocusMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-474,-405",
				["ElvUF_TargetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,285,62",
				["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,1,80",
				["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,737",
				["ElvBar_Totem"] = "BOTTOM,ElvUIParent,BOTTOM,0,55",
				["ElvUF_PetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-474,511",
				["VehicleSeatMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,4,-4",
				["ElvUF_PartyMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,248",
				["AlertFrameMover"] = "TOP,ElvUIParent,TOP,-1,-18",
				["ElvUF_RaidMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,4,248",
				["ElvUF_TargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-550,84",
			},
			["unitframe"] = {
				["smoothbars"] = true,
				["units"] = {
					["pet"] = {
						["debuffs"] = {
							["enable"] = true,
							["anchorPoint"] = "TOPRIGHT",
						},
						["disableTargetGlow"] = false,
						["castbar"] = {
							["iconSize"] = 32,
							["width"] = 270,
						},
						["width"] = 270,
						["infoPanel"] = {
							["height"] = 14,
						},
						["portrait"] = {
							["camDistanceScale"] = 2,
						},
					},
					["boss"] = {
						["debuffs"] = {
							["sizeOverride"] = 27,
							["yOffset"] = -16,
							["numrows"] = 1,
							["maxDuration"] = 300,
						},
						["portrait"] = {
							["width"] = 45,
							["camDistanceScale"] = 2,
						},
						["castbar"] = {
							["width"] = 246,
						},
						["width"] = 246,
						["infoPanel"] = {
							["height"] = 17,
						},
						["height"] = 60,
						["buffs"] = {
							["sizeOverride"] = 27,
							["yOffset"] = 16,
							["maxDuration"] = 300,
						},
					},
					["party"] = {
						["height"] = 74,
						["rdebuffs"] = {
							["font"] = "PT Sans Narrow",
						},
						["power"] = {
							["height"] = 13,
						},
						["width"] = 231,
					},
					["raid40"] = {
						["enable"] = false,
						["rdebuffs"] = {
							["font"] = "PT Sans Narrow",
						},
					},
					["focus"] = {
						["castbar"] = {
							["width"] = 270,
						},
						["width"] = 270,
					},
					["target"] = {
						["combobar"] = {
							["height"] = 14,
						},
						["orientation"] = "LEFT",
						["aurabar"] = {
							["enable"] = false,
						},
						["power"] = {
							["attachTextTo"] = "InfoPanel",
						},
						["disableMouseoverGlow"] = true,
						["width"] = 250,
						["infoPanel"] = {
							["enable"] = true,
						},
						["portrait"] = {
							["overlay"] = true,
							["enable"] = true,
							["camDistanceScale"] = 0.8300000000000001,
						},
						["name"] = {
							["attachTextTo"] = "InfoPanel",
						},
						["castbar"] = {
							["insideInfoPanel"] = false,
							["width"] = 250,
							["height"] = 20,
						},
						["height"] = 70,
						["health"] = {
							["attachTextTo"] = "InfoPanel",
						},
					},
					["raid"] = {
						["infoPanel"] = {
							["enable"] = true,
						},
						["name"] = {
							["attachTextTo"] = "InfoPanel",
							["position"] = "BOTTOMLEFT",
							["xOffset"] = 2,
						},
						["visibility"] = "[@raid6,noexists] hide;show",
						["rdebuffs"] = {
							["xOffset"] = 30,
							["yOffset"] = 25,
							["font"] = "PT Sans Narrow",
							["size"] = 30,
						},
						["growthDirection"] = "RIGHT_UP",
						["resurrectIcon"] = {
							["attachTo"] = "BOTTOMRIGHT",
						},
						["width"] = 92,
						["numGroups"] = 8,
						["roleIcon"] = {
							["attachTo"] = "InfoPanel",
							["position"] = "BOTTOMRIGHT",
							["xOffset"] = 0,
							["size"] = 12,
						},
					},
					["player"] = {
						["debuffs"] = {
							["attachTo"] = "BUFFS",
						},
						["classbar"] = {
							["height"] = 14,
						},
						["aurabar"] = {
							["enable"] = false,
						},
						["castbar"] = {
							["xOffsetText"] = 95,
							["insideInfoPanel"] = false,
							["width"] = 305,
							["height"] = 20,
						},
						["disableMouseoverGlow"] = true,
						["width"] = 250,
						["infoPanel"] = {
							["enable"] = true,
						},
						["health"] = {
							["attachTextTo"] = "InfoPanel",
						},
						["portrait"] = {
							["overlay"] = true,
							["enable"] = true,
							["camDistanceScale"] = 0.8300000000000001,
							["overlayAlpha"] = 0.64,
						},
						["height"] = 70,
						["buffs"] = {
							["attachTo"] = "FRAME",
						},
						["power"] = {
							["attachTextTo"] = "InfoPanel",
						},
					},
					["targettarget"] = {
						["debuffs"] = {
							["enable"] = false,
							["anchorPoint"] = "TOPRIGHT",
						},
						["threatStyle"] = "GLOW",
						["power"] = {
							["enable"] = false,
						},
						["disableMouseoverGlow"] = true,
						["width"] = 50,
						["height"] = 90,
						["raidicon"] = {
							["attachTo"] = "LEFT",
							["xOffset"] = 2,
							["enable"] = false,
							["yOffset"] = 0,
						},
					},
				},
				["colors"] = {
					["healthclass"] = true,
					["castClassColor"] = true,
					["auraBarBuff"] = {
						["r"] = 0.99,
						["g"] = 0.99,
						["b"] = 0.99,
					},
				},
			},
			["actionbar"] = {
				["bar3"] = {
					["buttonsPerRow"] = 10,
					["buttonSpacing"] = 1,
					["buttonSize"] = 50,
				},
				["bar1"] = {
					["buttons"] = 6,
					["buttonSpacing"] = 1,
					["buttonSize"] = 50,
				},
				["bar2"] = {
					["enabled"] = true,
					["buttonSize"] = 38,
					["buttonSpacing"] = 1,
					["buttons"] = 9,
				},
				["bar5"] = {
					["enabled"] = false,
				},
				["bar4"] = {
					["enabled"] = false,
				},
			},
			["general"] = {
				["valuecolor"] = {
					["g"] = 0.99,
					["b"] = 0.99,
				},
				["watchFrameHeight"] = 400,
				["minimap"] = {
					["size"] = 220,
				},
				["totems"] = {
					["spacing"] = 8,
					["size"] = 50,
					["growthDirection"] = "HORIZONTAL",
				},
			},
			["auras"] = {
				["debuffs"] = {
					["size"] = 40,
				},
				["buffs"] = {
					["size"] = 40,
				},
			},
		},
	},
}
ElvPrivateDB = {
	["profileKeys"] = {
		["Ninfuu - Apollo 2"] = "Ninfuu - Apollo 2",
	},
	["profiles"] = {
		["Ninfuu - Apollo 2"] = {
			["general"] = {
				["glossTex"] = "Minimalist",
			},
			["theme"] = "class",
			["install_complete"] = 2.92,
		},
	},
}
