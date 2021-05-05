
local L = LibStub("AceLocale-3.0"):NewLocale("Parrot", "zhCN")
if not L then return end

L["Control game options"] = "控制游戏选项"
L["Display realm in player names (in battlegrounds)"] = "显示服务器名称（在战场）"
L["Floating Combat Text of awesomeness. Caw. It'll eat your crackers."] = "绝妙的战斗记录指示器。"
L["Game damage"] = "默认伤害"
L["Game healing"] = "默认治疗"
L["Game options"] = "游戏选项"
L["General"] = "通用"
L["General settings"] = "通用设置"
L["Inherit"] = "继承"
L["Load config"] = "加载配置"
L["Load configuration options"] = "加载配置选项"
L["Parrot"] = "Parrot"
L["Parrot Configuration"] = "Parrot 配置"
L["Show guardian events"] = "显示守卫事件"
L["Show realm name"] = "显示服务器名称"
L[ [=[Whether Parrot should control the default interface's options below.
These settings always override manual changes to the default interface options.]=] ] = [=[Parrot 是否控制下面的默认界面选项。
这些设置总是覆盖默认界面选项的手动更改。]=]
L["Whether events involving your guardian(s) (totems, ...) should be displayed"] = "显示所有与守卫（如：图腾，…）相关的事件"
L["Whether to show damage over the enemy's heads."] = "是否在敌人头上显示伤害值。"
L["Whether to show healing over the enemy's heads."] = "是否在敌人头上显示治疗量。"


L = LibStub("AceLocale-3.0"):NewLocale("Parrot_CombatEvents", "zhCN")
L[" ([Amount] absorbed)"] = "（吸收 [Amount]）"
L[" ([Amount] blocked)"] = "（格挡 [Amount]）"
L[" ([Amount] overheal)"] = "（过量治疗 [Amount]）"
L[" ([Amount] overkill)"] = "（伤害溢出 [Amount]）"
L[" ([Amount] resisted)"] = "（抵抗 [Amount]）"
L[" ([Amount] vulnerable)"] = "（易伤 [Amount]）"
L["<Tag>"] = "<标签>"
L["<Text>"] = "<文本>"
L["Abbreviate"] = "缩写"
L["Abbrivate number values displayed (26000 -> 26k)"] = "缩写数值显示（26000 -> 26k)"
L["Add a new filter."] = "添加一个新过滤。"
L["Add a new throttle."] = "添加一个新流量控制"
L["Always hide skill names even when present in the tag"] = "在当前标签总是隐藏技能名称"
L["Always hide unit names even when present in the tag"] = "在当前标签总是隐藏单位名称"
L["Amount"] = "数值"
L["Arcane"] = "奥术"
L["Change event settings"] = "改变事件设置"
L["Classcolor names"] = "职业颜色名称"
L["Color"] = "颜色"
L["Color by class"] = "职业着色"
L["Color names in the texts with the color of the class"] = "名称文字以职业颜色着色"
L["Color of the text for the current event."] = "当前事件的文本颜色。"
L["Color unit names by class"] = "单位名称使用职业颜色"
L["Critical hits/heals"] = "爆击伤害/治疗"
L["Crushing blows"] = "碾压"
L["Custom font"] = "自定义字体"
L["Damage types"] = "伤害类型"
L["Disable CombatEvents when in a 10-man raid instance"] = "当10人团队时禁用战斗事件"
L["Disable CombatEvents when in a 25-man raid instance"] = "当25人团队时禁用战斗事件"
L["Disable in 10-man raids"] = "当10人团队时禁用"
L["Disable in 25-man raids"] = "当25人团队时禁用"
L["Do not shorten spell names."] = "不对法术名称进行缩略。"
L["Do not show heal events when 100% of the amount is overheal"] = "当100%的过量治疗时不显示治疗事件"
L["Enable the current event."] = "应用当前事件。"
L["Enable to show crits in the sticky style."] = "允许将爆击用粘附的风格显示。"
L["Enabled"] = "应用"
L["Event modifiers"] = "事件修饰"
L["Events"] = "事件"
L["Filter incoming spells"] = "过滤承受法术"
L["Filter outgoing spells"] = "过滤输出法术"
L["Filter when amount is lower than this value (leave blank to filter everything)"] = "小于此数值时过滤（留空过滤所有）"
L["Filters"] = "过滤"
L["Filters that are applied to a single spell"] = "过滤单一法术"
L["Filters to be checked for a minimum amount of damage/healing/etc before showing."] = "过滤显示小于特定值的伤害/治疗/其他信息。"
L["Fire"] = "火焰"
L["Font face"] = "字体"
L["Font outline"] = "字体勾勒"
L["Font size"] = "字号"
L["Frost"] = "冰霜"
L["Frostfire"] = "霜火之箭"
L["Froststorm"] = "冰霜风暴吐息"
L["Gift of the Wild => Gift of t..."] = "真言术：韧 => 真言术...。"
L["Gift of the Wild => GotW."] = "真言术：韧 => 韧。"
L["Glancing hits"] = "偏斜"
L["Hide events used in triggers"] = "用于隐藏事件触发"
L["Hide full overheals"] = "隐藏全部过量治疗"
L["Hide realm"] = "隐藏服务器名"
L["Hide realm in player names (in battlegrounds)"] = "隐藏玩家名称的服务器名（在战场）"
L["Hide skill names"] = "隐藏技能名称"
L["Hide unit names"] = "隐藏单位名称"
L["Hides combat events when they were used in triggers"] = "用于隐藏战斗事件触发"
L["Holy"] = "神圣"
L["How or whether to shorten spell names."] = "是否或如何缩略法术名称。"
L["Incoming"] = "承受"
L["Incoming events are events which a mob or another player does to you."] = "承受事件是那些怪物或玩家对你造成的事件。"
L["Inherit"] = "继承"
L["Inherit font size"] = "继承字号"
L["Interval for collecting data"] = "间歇性收集数据"
L["Length"] = "长度"
L["Name or ID of the spell"] = "法术名称或 ID "
L["Nature"] = "自然"
L["New filter"] = "新过滤"
L["New throttle"] = "新流量控制"
L["None"] = "无"
L["Notification"] = "提示"
L["Notification events are available to notify you of certain actions."] = "提示事件用来提醒你某个特定动作的触发。"
L["Options for damage types."] = "伤害类型的选项。"
L["Options for event modifiers."] = "事件修饰的选项。"
L["Outgoing"] = "输出"
L["Outgoing events are events which you do to a mob or another player."] = "输出事件是那些你对怪物或玩家造成的事件。"
L["Overheals"] = "过量治疗"
L["Overkills"] = "伤害溢出"
L["Partial absorbs"] = "部分吸收"
L["Partial blocks"] = "部分格挡"
L["Partial resists"] = "部分抵抗"
L["Physical"] = "物理"
L["Remove"] = "移除"
L["Remove filter"] = "移除过滤"
L["Remove throttle"] = "移除流量控制"
L["Scoll area where all events will be shown"] = "在滚动区域显示所有事件"
L["Scroll area"] = "滚动区域"
L["Shadow"] = "暗影"
L["Shadowstorm"] = "暗影风暴"
L["Short Texts"] = "缩写文本"
L["Shorten Amounts"] = "缩写数值"
L["Shorten spell names"] = "缩略法术名称"
L["Show guardian events"] = "显示守卫事件"
L["Sound"] = "音效"
L["Spell"] = "法术"
L["Spell filters"] = "法术过滤"
L["Spell throttles"] = "法术流量控制"
L["Sticky"] = "粘附"
L["Sticky crits"] = "爆击粘附"
L["Style"] = "风格"
L["Tag"] = "标识"
L["Tag to show for the current event."] = "标识显示当前事件。"
L["Text"] = "文本"
L["Text options"] = "文本选项"
L["The amount of damage absorbed."] = "被吸收的伤害量。"
L["The amount of damage blocked."] = "被格挡的伤害量。"
L["The amount of damage resisted."] = "被抵抗的伤害量。"
L["The amount of overhealing."] = "过量治疗量。"
L["The amount of overkill."] = "伤害溢出量。"
L["The amount of vulnerability bonus."] = "易伤加成量。"
L["The length at which to shorten spell names."] = "需要进行法术名称缩略的长度。"
L["The normal text."] = "一般文本。"
L["Thick"] = "粗"
L["Thin"] = "细"
L["Throttle events"] = "事件节流"
L["Throttle time"] = "流量控制时间"
L["Throttles that are applied to a single spell"] = "适用于一个单一法术的流量控制"
L["Truncate"] = "截短"
L["Uncategorized"] = "未分类"
L["Use short throttle-texts (like \"2++\" instead of \"2 crits\")"] = "使用缩写文本（例如“2++”代表“2爆击”）"
L["Vulnerability bonuses"] = "易伤加成"
L[ [=[What amount to filter out. Any amount below this will be filtered.
Note: a value of 0 will mean no filtering takes place.]=] ] = [=[需要过滤的值，低于该值将被过滤
注意：若过滤值为0则表示不进行过滤。]=]
L["What color this damage type takes on."] = "此伤害类型采用何种颜色。"
L["What color this event modifier takes on."] = "事件修饰采用何种颜色。"
L["What sound to play when the current event occurs."] = "当前事件发生时播放哪个音效。"
L["What text this event modifier shows."] = "事件修饰显示什么文本。"
L[ [=[What timespan to merge events within.
Note: a time of 0s means no throttling will occur.]=] ] = [=[合并事件的时间间隔（单位秒）
注意：0表示不进行节流显示。]=]
L["Whether all events in this category are enabled."] = "是否所有事件在这个类别中启用。"
L["Whether events involving your guardian(s) (totems, ...) should be displayed"] = "显示所有与守卫（如：图腾，…）相关的事件"
L["Whether the current event should be classified as \"Sticky\""] = "是否将当前事件以\"粘附\"方式显示"
L["Whether this module is enabled"] = "是否启用此模块"
L["Whether to color damage types or not."] = "是否为伤害类型上色。"
L["Whether to color event modifiers or not."] = "是否为事件修饰上色。"
L["Whether to enable showing this event modifier."] = "是否应用事件修饰显示。"
L["Whether to merge mass events into single instances instead of excessive spam."] = "是否将大量同类事件整合为一个单一事件而避免信息泛滥。"
L["Which scroll area to use."] = "应用哪个滚动区域。"
L["[Text] (crit)"] = "[Text]（爆击）"
L["[Text] (crushing)"] = "[Text]（碾压）"
L["[Text] (glancing)"] = "[Text]（偏斜）"


L = LibStub("AceLocale-3.0"):NewLocale("Parrot_Display", "zhCN")
L["Enable icons"] = "应用图标"
L["How opaque/transparent icons should be."] = "图标显示的透明度。"
L["How opaque/transparent the text should be."] = "文本显示的透明度。"
L["Icon transparency"] = "图标透明度"
L["Master font settings"] = "主字体设置"
L["None"] = "无"
L["Normal font"] = "正常字体"
L["Normal font face."] = "正常字体。"
L["Normal font size"] = "正常字号"
L["Normal outline"] = "正常勾勒"
L["Set whether icons should be enabled or disabled altogether."] = "设置是否图标要被一起显示。"
L["Sticky font"] = "粘附字体"
L["Sticky font face."] = "粘附字体。"
L["Sticky font size"] = "粘附字号"
L["Sticky outline"] = "粘附勾勒"
L["Text transparency"] = "文本透明度"
L["Thick"] = "粗"
L["Thin"] = "细"


L = LibStub("AceLocale-3.0"):NewLocale("Parrot_ScrollAreas", "zhCN")
L["<Name>"] = "<名称>"
L["Add a new scroll area."] = "增加一个新的滚动区域。"
L["Animation style"] = "动画效果"
L["Animation style for normal texts."] = "正常文字的动画效果。"
L["Animation style for sticky texts."] = "粘附文字的动画效果。"
L["Are you sure?"] = "是否确定？"
L["Center of screen"] = "屏幕中央"
L["Click and drag to the position you want."] = "拖动到你希望的位置。"
L["Configuration mode"] = "配置模式"
L["Create"] = "创建"
L["Custom font"] = "自定义字体"
L["Direction"] = "方向"
L["Direction for normal texts."] = "正常文字的方向。"
L["Direction for sticky texts."] = "粘附文字的方向。"
L["Disable"] = "禁用"
L["Edge of screen"] = "屏幕边缘"
L["Enter configuration mode, allowing you to move around the scroll areas and see them in action."] = "进入配置模式，让你可以移动滚动区域并观看效果。"
L["How fast the text scrolls by."] = "设置以多快的速度滚动。"
L["How large of an area to scroll."] = "滚动区域的大小。"
L["Icon side"] = "图标位置"
L["Incoming"] = "承受"
L["Inherit"] = "继承"
L["Left"] = "左"
L["Name"] = "名称"
L["Name of the scroll area."] = "滚动区域的名称。"
L["New scroll area"] = "新增滚动区域"
L["None"] = "无"
L["Normal"] = "正常"
L["Normal font face"] = "正常字体"
L["Normal font outline"] = "正常字体勾勒"
L["Normal font size"] = "正常字号"
L["Normal inherit font size"] = "继承正常字号"
L["Notification"] = "提示"
L["Options for this scroll area."] = "本滚动区域的选项。"
L["Options regarding scroll areas."] = "滚动区域的选项。"
L["Outgoing"] = "输出"
L["Position: %d, %d"] = "位置：%d，%d"
L["Position: horizontal"] = "水平位置"
L["Position: vertical"] = "垂直位置"
L["Remove"] = "移除"
L["Remove this scroll area."] = "移除本滚动区域。"
L["Right"] = "右"
L["Scroll area: %s"] = "滚动区域：%s"
L["Scroll areas"] = "滚动区域"
L["Scrolling speed"] = "滚动速度"
L["Seconds for the text to complete the whole cycle, i.e. larger numbers means slower."] = "完成整个滚动循环的秒数，数字越大滚动越慢。"
L["Send"] = "发送"
L["Send a normal test message."] = "发送一条正常测试信息。"
L["Send a sticky test message."] = "发送一条粘附测试信息。"
L["Send a test message through this scroll area."] = "发送一条测试信息到本滚动区域。"
L["Set the icon side for this scroll area or whether to disable icons entirely."] = "设置本滚动区域的图标位置或是否完全禁用图标。"
L["Size"] = "大小"
L["Sticky"] = "粘附"
L["Sticky font face"] = "粘附字体"
L["Sticky font outline"] = "粘附字体勾勒"
L["Sticky font size"] = "粘附字号"
L["Sticky inherit font size"] = "继承粘附字号"
L["Test"] = "测试"
L["The position of the box across the screen"] = "在屏幕上的水平位置"
L["The position of the box up-and-down the screen"] = "在屏幕上的垂直位置"
L["Thick"] = "粗"
L["Thin"] = "细"
L["Which animation style to use."] = "采用何种动画效果。"
L["Which direction the animations should follow."] = "滚动动画的方向。"


L = LibStub("AceLocale-3.0"):NewLocale("Parrot_Suppressions", "zhCN")
L["<Any text> or <Lua search expression>"] = "<任意文字>或<Lua 搜索表达式>"
L["Add a new suppression."] = "增加一个新的覆盖事件。"
L["Are you sure?"] = "是否确定？"
L["Create"] = "创建"
L["Edit"] = "编辑"
L["Edit search string"] = "编辑搜索字符串"
L["List of strings that will be squelched if found."] = "列出的字符串若找到则被覆盖。"
L["Lua search expression"] = "Lua 搜索表达式"
L["New suppression"] = "新增覆盖事件"
L["Remove"] = "移除"
L["Remove suppression"] = "移除覆盖事件"
L["Suppressions"] = "覆盖事件"
L["Whether the search string is a lua search expression or not."] = "是否搜索字符串是一个 Lua 搜索表达式。"


L = LibStub("AceLocale-3.0"):NewLocale("Parrot_Triggers", "zhCN")
L["%s!"] = "%s！"
L["<Spell name> or <Item name> or <Path> or <SpellId>"] = "<法术名称>或<物品名称>或<路径>或<法术 ID>"
L["<Text to show>"] = "<显示文本>"
L["Add a new primary condition"] = "增加一个新的主条件"
L["Add a new secondary condition"] = "增加一个新的次条件"
L["Are you sure?"] = "是否确定？"
L["Check every XX seconds"] = "每过 XX 秒检查一次"
L["Classes"] = "职业"
L["Classes affected by this trigger."] = "本条件触发所影响的职业。"
L["Cleanup Triggers"] = "删除条件触发"
L["Color"] = "颜色"
L["Color in which to flash"] = "闪光颜色"
L["Color of the text for this trigger."] = "这个条件触发的显示文本颜色。"
L["Create"] = "创建"
L["Create a new trigger"] = "创建一个新的条件触发"
L["Custom font"] = "自定义字体"
L["Delete all Triggers that belong to a different locale"] = "删除所有不同本地化的条件触发"
L["Enabled"] = "应用"
L["Flash screen in specified color"] = "指定屏幕闪光颜色"
L["Font face"] = "字体"
L["Font outline"] = "字体勾勒"
L["Font size"] = "字号"
L["Free %s!"] = "额外%s！"
L["Icon"] = "图标"
L["Inherit"] = "继承"
L["Inherit font size"] = "继承字号"
L["Low Health!"] = "低血量！"
L["Low Mana!"] = "低法力！"
L["Low Pet Health!"] = "宠物低血量！"
L["New condition"] = "新增条件"
L["New trigger"] = "新增条件触发"
L["None"] = "无"
L["Output"] = "输出"
L["Primary conditions"] = "主条件"
L["Remove"] = "移除"
L["Remove a primary condition"] = "移除一个主条件"
L["Remove a secondary condition"] = "移除一个次条件"
L["Remove condition"] = "移除条件"
L["Remove this trigger completely."] = "彻底移除这个条件触发。"
L["Remove trigger"] = "移除条件触发"
L["Scroll area"] = "滚动区域"
L["Secondary conditions"] = "次条件"
L["Sound"] = "音效"
L["Sticky"] = "粘附"
L["Test"] = "测试"
L["Test how the trigger will look and act."] = "测试条件触发的效果。"
L["The icon that is shown"] = "想要显示的图标"
L["The text that is shown"] = "想要显示的文本"
L["Thick"] = "粗"
L["Thin"] = "细"
L["Trigger cooldown"] = "触发冷却"
L["Triggers"] = "条件触发"
L["What sound to play when the trigger is shown."] = "条件触发显示时播放何种音效。"
L["When all of these conditions apply, the trigger will be shown."] = "当所有这些条件被满足时，条件触发将被显示。"
L["When any of these conditions apply, the secondary conditions are checked."] = "当这些条件中的任一个满足时，检查次条件。"
L["Whether the trigger is enabled or not."] = "是否应用这个条件触发。"
L["Whether to show this trigger as a sticky."] = "是否将本条件触发粘附显示。"
L["Which scroll area to output to."] = "选择输出的滚动区域。"


L = LibStub("AceLocale-3.0"):NewLocale("Parrot_TriggerConditions", "zhCN")


L = LibStub("AceLocale-3.0"):NewLocale("Parrot_AnimationStyles", "zhCN")
L["Action"] = "动作型"
L["Action Sticky"] = "动态粘附"
L["Alternating"] = "交错"
L["Angled"] = "角度型"
L["Down, alternating"] = "向下，交错"
L["Down, center-aligned"] = "向下，中对齐"
L["Down, clockwise"] = "向下，顺时针"
L["Down, counter-clockwise"] = "向下，逆时针"
L["Down, left"] = "向下，向左"
L["Down, left-aligned"] = "向下，左对齐"
L["Down, right"] = "向下，向右"
L["Down, right-aligned"] = "向下，右对齐"
L["Horizontal"] = "横移型"
L["Left"] = "左"
L["Left, clockwise"] = "向左，顺时针"
L["Left, counter-clockwise"] = "向左，逆时针"
L["Parabola"] = "抛物线"
L["Pow"] = "震动型"
L["Rainbow"] = "彩虹型"
L["Right"] = "右"
L["Right, clockwise"] = "向右，顺时针"
L["Right, counter-clockwise"] = "向右，逆时针"
L["Semicircle"] = "半圆型"
L["Sprinkler"] = "洒水型"
L["Static"] = "静态型"
L["Straight"] = "直线型"
L["Up, alternating"] = "向上，交错"
L["Up, center-aligned"] = "向上，中对齐"
L["Up, clockwise"] = "向上，顺时针"
L["Up, counter-clockwise"] = "向上，逆时针"
L["Up, left"] = "向上，向左"
L["Up, left-aligned"] = "向上，左对齐"
L["Up, right"] = "向上，向右"
L["Up, right-aligned"] = "向上，右对齐"


L = LibStub("AceLocale-3.0"):NewLocale("Parrot_Auras", "zhCN")
L["<Buff name or spell id>"] = "<增益名称或法术 ID>"
L["<Buff name or spell id>,<Number of stacks>"] = "<增益名称或法术 ID>,<叠加层数>"
L["<Buff name>"] = "<增益名称>"
L["<Debuff name or spell id>"] = "<减益名称或法术 ID>"
L["<Debuff name>"] = "<减益名称>"
L["<Item buff name>"] = "<物品增益名称>"
L["Amount"] = "数值"
L["Amount of stacks of the aura"] = "光环叠加层数"
L["Any"] = "任意"
L["Aura active"] = "光环激活"
L["Aura fade"] = "光环消退"
L["Aura gain"] = "获得光环"
L["Aura inactive"] = "光环未激活"
L["Aura stack gain"] = "获得光环叠加"
L["Aura type"] = "光环类型"
L["Auras"] = "光环"
L["Both"] = "双"
L["Buff"] = "增益"
L["Buff active"] = "增益激活"
L["Buff fades"] = "增益消退"
L["Buff gains"] = "获得增益"
L["Buff inactive"] = "增益未激活"
L["Buff name"] = "增益名称"
L["Buff name or spell id"] = "增益名称或法术 ID"
L["Buff stack gains"] = "获得增益叠加"
L["Debuff"] = "减益"
L["Debuff active"] = "减益激活"
L["Debuff fades"] = "减益消退"
L["Debuff gains"] = "受到减益"
L["Debuff inactive"] = "减益未启用"
L["Debuff stack gains"] = "减益叠加消退"
L["Enemy buff fades"] = "敌对增益消退"
L["Enemy buff gains"] = "敌对增益获取"
L["Enemy debuff fades"] = "敌对减益消退"
L["Enemy debuff gains"] = "敌对减益获取"
L["Focus buff fade"] = "焦点目标增益消退"
L["Focus buff gain"] = "焦点目标获得增益"
L["Focus debuff fade"] = "焦点目标减益消退"
L["Focus debuff gain"] = "焦点目标获得减益"
L["Item buff active"] = "物品增益激活"
L["Item buff fade"] = "物品增益消退"
L["Item buff fades"] = "物品增益消退"
L["Item buff gain"] = "获得物品增益"
L["Item buff gains"] = "获得物品增益"
L["Main hand"] = "主手"
L["New Amount of stacks of the buff."] = "新的增益叠加层数。"
L["New Amount of stacks of the debuff."] = "新的减益叠加层数。"
L["Off hand"] = "副手"
L["Only return true, if the Aura has been applied by yourself"] = "只有选定时，自身光环可用"
L["Own aura"] = "自身光环"
L["Pet buff fades"] = "宠物增益消退"
L["Pet buff gains"] = "宠物增益获取"
L["Pet debuff fades"] = "宠物减益消退"
L["Pet debuff gains"] = "宠物减益获取"
L["Self buff fade"] = "自身增益消退"
L["Self buff gain"] = "获得自身增益"
L["Self buff stacks gain"] = "获得自身增益叠加"
L["Self debuff fade"] = "自身减益消退"
L["Self debuff gain"] = "获得自身减益"
L["Self item buff fade"] = "自身物品增益消退"
L["Self item buff gain"] = "获得自身物品增益"
L["Spell"] = "法术"
L["Stack count"] = "堆叠数字"
L["Target buff fade"] = "目标增益消退"
L["Target buff gain"] = "目标获得增益"
L["Target buff gains"] = "目标获得增益"
L["Target buff stack gains"] = "目标获得增益叠加"
L["Target debuff fade"] = "目标减益消退"
L["Target debuff gain"] = "目标获得减益"
L["The enemy that gained the buff"] = "敌对获取的增益"
L["The enemy that gained the debuff"] = "敌对获取的减益"
L["The enemy that lost the buff"] = "敌对消退的增益"
L["The enemy that lost the debuff"] = "敌对消退的减益"
L["The name of the buff gained."] = "获得增益的名称。"
L["The name of the buff lost."] = "消退增益的名称。"
L["The name of the debuff gained."] = "受到减益的名称。"
L["The name of the debuff lost."] = "消退减益的名称。"
L["The name of the item buff gained."] = "获得物品增益的名称。"
L["The name of the item buff lost."] = "消退物品增益的名称。"
L["The name of the item, the buff has been applied to."] = "获得物品增益的名称。"
L["The name of the item, the buff has faded from."] = "消退物品增益的名称。"
L["The name of the pet that gained the buff"] = "宠物获取的增益名称"
L["The name of the pet that gained the debuff"] = "宠物获取的减益名称"
L["The name of the pet that lost the buff"] = "宠物消退的增益名称"
L["The name of the pet that lost the debuff"] = "宠物消退的减益名称"
L["The name of the unit that gained the buff."] = "单位获得增益的名称。"
L["The number of stacks of the buff"] = "增益堆叠数字"
L["The unit that is affected"] = "受到影响的单位"
L["Type of the aura"] = "光环类型"
L["Unit"] = "单位"


-- L["The rank of the item buff gained."] = true -- not used anymore
-- L["The rank of the item buff lost."] = true -- not used anymore

L = LibStub("AceLocale-3.0"):NewLocale("Parrot_CombatEvents_Data", "zhCN")
L[" (%d crits)"] = "（%d次爆击）"
L[" (%d gains)"] = "（获得%d点）"
L[" (%d heal, %d crit)"] = "（%d次治疗，%d次爆击）"
L[" (%d heal, %d crits)"] = "（%d次治疗，%d次爆击）"
L[" (%d heals)"] = "（%d次治疗）"
L[" (%d heals, %d crit)"] = "（%d次治疗，%d次爆击）"
L[" (%d heals, %d crits)"] = "（%d次治疗，%d次爆击）"
L[" (%d hit, %d crit)"] = "（%d次命中，%d次爆击）"
L[" (%d hit, %d crits)"] = "（%d次命中，%d次爆击）"
L[" (%d hits)"] = "（%d次）"
L[" (%d hits, %d crit)"] = "（%d次命中，%d次爆击）"
L[" (%d hits, %d crits)"] = "（%d次命中，%d次爆击）"
L[" (%d losses)"] = "（失去%s点）"
L["%s failed"] = "%s失败"
L["%s stole %s"] = "%s偷取%s"
L["%s!"] = "%s！"
L["(Pet) +[Amount]"] = "+[Amount]（宠物）"
L["(Pet) -[Amount]"] = "-[Amount]（宠物）"
L["Ability blocks"] = "技能格挡"
L["Ability dodges"] = "技能躲闪"
L["Ability misses"] = "技能未命中"
L["Ability parries"] = "技能招架"
L["Amount of the damage that was missed."] = "伤害减少量。"
L["Arcane"] = "奥术"
L["Avoids"] = "减免"
L["Combat status"] = "战斗状态"
L["Combo point gain"] = "获得连击点"
L["Combo points"] = "连击点"
L["Combo points full"] = "连击点已满"
L["Damage"] = "伤害"
L["Dispel"] = "驱散"
L["Dispel fail"] = "驱散失败"
L["DoTs and HoTs"] = "DoT 和 HoT"
L["Dodge!"] = "躲闪！"
L["Enter combat"] = "进入战斗"
L["Environmental damage"] = "环境伤害"
L["Evade!"] = "闪避！"
L["Experience gains"] = "获得经验"
L["Extra attacks"] = "额外攻击"
L["Fire"] = "火焰"
L["Frost"] = "冰霜"
L["Heals"] = "治疗"
L["Heals over time"] = "持续治疗"
L["Holy"] = "神圣"
L["Honor gains"] = "获得荣誉"
L["Immune!"] = "免疫！"
L["Incoming damage"] = "承受伤害"
L["Incoming heals"] = "受到治疗"
L["Interrupt!"] = "打断！"
L["Killing Blow!"] = "杀死！"
L["Killing blows"] = "杀死"
L["Leave combat"] = "脱离战斗"
L["Melee"] = "近战"
L["Melee absorbs"] = "近战吸收"
L["Melee blocks"] = "近战格挡"
L["Melee damage"] = "近战伤害"
L["Melee deflects"] = "物理偏转"
L["Melee dodges"] = "近战躲闪"
L["Melee evades"] = "近战闪避"
L["Melee immunes"] = "近战免疫"
L["Melee misses"] = "近战未命中"
L["Melee parries"] = "近战招架"
L["Melee reflects"] = "物理反射"
L["Melee resists"] = "物理抵抗"
L["Miss!"] = "未命中！"
L["Misses"] = "未击中"
L["Multiple"] = "多重"
L["NPC killing blows"] = "杀死 NPC"
L["Nature"] = "自然"
L["Other"] = "其他"
L["Outgoing damage"] = "输出伤害"
L["Outgoing heals"] = "输出治疗"
L["Parry!"] = "招架！"
L["Pet Absorb!"] = "吸收！（宠物）"
L["Pet Block!"] = "格挡！（宠物）"
L["Pet Dodge!"] = "躲闪！（宠物）"
L["Pet Evade!"] = "闪避！（宠物）"
L["Pet Immune!"] = "免疫！（宠物）"
L["Pet Miss!"] = "未命中！（宠物）"
L["Pet Parry!"] = "招架！（宠物）"
L["Pet Reflect!"] = "反射！（宠物）"
L["Pet Resist!"] = "抵抗！（宠物）"
L["Pet [Amount] ([Skill])"] = "[Amount]（[Skill]）（宠物）"
L["Pet ability blocks"] = "技能格挡（宠物）"
L["Pet ability dodges"] = "技能躲闪（宠物）"
L["Pet ability misses"] = "技能未命中（宠物）"
L["Pet ability parries"] = "技能招架（宠物）"
L["Pet damage"] = "宠物伤害"
L["Pet heals"] = "治疗（宠物）"
L["Pet heals over time"] = "宠物持续治疗"
L["Pet melee"] = "近战（宠物）"
L["Pet melee absorbs"] = "近战吸收（宠物）"
L["Pet melee blocks"] = "近战格挡（宠物）"
L["Pet melee damage"] = "近战伤害（宠物）"
L["Pet melee deflects"] = "宠物物理偏转"
L["Pet melee dodges"] = "近战躲闪（宠物）"
L["Pet melee evades"] = "近战闪避（宠物）"
L["Pet melee immunes"] = "近战免疫（宠物）"
L["Pet melee misses"] = "近战未命中（宠物）"
L["Pet melee parries"] = "近战招架（宠物）"
L["Pet melee reflects"] = "宠物物理反射"
L["Pet melee resists"] = "宠物物理抵抗"
L["Pet misses"] = "宠物未击中"
L["Pet siege damage"] = "宠物攻城伤害"
L["Pet skill"] = "宠物技能"
L["Pet skill DoTs"] = "宠物技能 DoTs"
L["Pet skill absorbs"] = "技能吸收（宠物）"
L["Pet skill blocks"] = "宠物技能格挡"
L["Pet skill damage"] = "宠物技能伤害"
L["Pet skill deflects"] = "宠物技能偏转"
L["Pet skill dodges"] = "宠物技能躲闪"
L["Pet skill evades"] = "技能闪避（宠物）"
L["Pet skill immunes"] = "技能免疫（宠物）"
L["Pet skill interrupts"] = "宠物技能打断"
L["Pet skill misses"] = "宠物技能未击中"
L["Pet skill parries"] = "宠物技能招架"
L["Pet skill reflects"] = "技能反射（宠物）"
L["Pet skill resists"] = "宠物技能抵抗"
L["Pet skills"] = "宠物技能"
L["Pet spell resists"] = "技能抵抗（宠物）"
L["Physical"] = "物理"
L["Player killing blows"] = "杀死玩家"
L["Power change"] = "能量变化"
L["Power gain"] = "获得能量"
L["Power gain/loss"] = "获得/失去能量"
L["Power loss"] = "失去能量"
L["Reactive skills"] = "反应技能"
L["Reflect!"] = "反射！"
L["Reputation"] = "声望"
L["Reputation gains"] = "获得声望"
L["Reputation losses"] = "失去声望"
L["Resist!"] = "抵抗！"
L["Self heals"] = "自身治疗"
L["Self heals over time"] = "自身治疗持续时间"
L["Shadow"] = "暗影"
L["Siege damage"] = "攻城伤害"
L["Skill DoTs"] = "技能 DoT"
L["Skill absorbs"] = "技能吸收"
L["Skill blocks"] = "技能格挡"
L["Skill damage"] = "技能伤害"
L["Skill deflects"] = "技能偏转"
L["Skill dodges"] = "技能躲闪"
L["Skill evades"] = "技能闪避"
L["Skill gains"] = "技能提升"
L["Skill immunes"] = "技能免疫"
L["Skill interrupts"] = "技能打断"
L["Skill misses"] = "技能未击中"
L["Skill parries"] = "技能招架"
L["Skill reflects"] = "技能反射"
L["Skill resists"] = "技能抵抗"
L["Skill you were interrupted in casting"] = "在你施法中打断的技能"
L["Skill your pet was interrupted in casting"] = "你的宠物正在施放技能被打断"
L["Skills"] = "技能"
L["Skills absorbs"] = "技能吸收"
L["Skills blocks"] = "技能格挡"
L["Skills dodges"] = "技能躲闪"
L["Skills evades"] = "技能闪避"
L["Skills immunes"] = "技能免疫"
L["Skills misses"] = "技能未击中"
L["Skills parries"] = "技能招架"
L["Skills reflects"] = "技能反射"
L["Skills resists"] = "技能抵抗"
L["Spell resists"] = "法术抵抗"
L["Spell steal"] = "法术偷取"
L["The ability or spell take away your power."] = "使用的技能或法术而失去能量。"
L["The ability or spell used to gain power."] = "为获得能量而使用的技能或法术。"
L["The ability or spell your pet used."] = "宠物所使用的技能或法术。"
L["The amount of damage done."] = "造成的伤害量。"
L["The amount of experience points gained."] = "获得的经验点数。"
L["The amount of healing done."] = "受到的治疗量。"
L["The amount of honor gained."] = "获得的荣誉点数。"
L["The amount of power gained."] = "获得能量数值。"
L["The amount of power lost."] = "失去能量数值。"
L["The amount of reputation gained."] = "获得的声望点数。"
L["The amount of reputation lost."] = "失去声望的点数。"
L["The amount of skill points currently."] = "当前的技能点数。"
L["The character that caused the power loss."] = "令你失去能量的角色。"
L["The character that the power comes from."] = "为你提供能量的角色。"
L["The current number of combo points."] = "当前的连击点数。"
L["The name of the ally that healed you."] = "治疗你的盟友名称。"
L["The name of the ally that healed your pet."] = "治疗你宠物的盟友名称。"
L["The name of the ally you healed."] = "你所治疗的盟友名称。"
L["The name of the enemy slain."] = "杀死的敌人名称。"
L["The name of the enemy that attacked you."] = "攻击你的敌人名称。"
L["The name of the enemy that attacked your pet."] = "攻击你宠物的敌人名称。"
L["The name of the enemy you attacked."] = "你所攻击的敌人名称。"
L["The name of the enemy your pet attacked."] = "宠物攻击的敌人名称。"
L["The name of the faction."] = "势力的名称。"
L["The name of the spell or ability which provided the extra attacks."] = "导致额外攻击的法术或技能名称。"
L["The name of the spell that has been dispelled."] = "被驱散的法术名称。"
L["The name of the spell that has been stolen."] = "被偷取的法术名称。"
L["The name of the spell that has been used for dispelling."] = "驱散所使用的法术名称。"
L["The name of the spell that has been used for stealing."] = "偷取所使用的法术名称。"
L["The name of the spell that has not been dispelled."] = "未被驱散的法术名称。"
L["The name of the unit from which the spell has been removed."] = "单位法术已被移除的名称。"
L["The name of the unit from which the spell has been stolen."] = "单位法术已被偷取的名称。"
L["The name of the unit from which the spell has not been removed."] = "单位法术未被偷取的名称。"
L["The name of the unit that dispelled the spell from you"] = "单位法术被你驱散的名称"
L["The name of the unit that failed dispelling the spell from you"] = "单位法术未被你驱散的名称"
L["The name of the unit that stole the spell from you"] = "单位法术被你偷取的名称"
L["The name of the unit that your pet healed."] = "你宠物治疗的单位名称。"
L["The rank of the enemy slain."] = "被杀死的敌人级别。"
L["The skill which experienced a gain."] = "获得提升的技能。"
L["The spell or ability that the ally healed you with."] = "盟友用来治疗你的法术名称。"
L["The spell or ability that the ally healed your pet with."] = "治疗你宠物的法术或技能。"
L["The spell or ability that the enemy attacked you with."] = "敌人攻击你所用的法术或技能。"
L["The spell or ability that the enemy attacked your pet with."] = "敌人攻击你宠物的法术或技能。"
L["The spell or ability that the pet used to heal."] = "你宠物使用的治疗法术或技能。"
L["The spell or ability that you used."] = "你所使用的法术或技能。"
L["The spell or ability that your pet used."] = "你宠物使用的法术或技能。"
L["The spell or ability used to slay the enemy."] = "用来杀死敌人的法术或技能。"
L["The spell you interrupted"] = "你打断的技能"
L["The spell your pet interrupted"] = "你宠物所打断的技能"
L["The type of damage done."] = "造成伤害的类型。"
L["The type of power gained (Mana, Rage, Energy)."] = "获得能量的类型（法力，怒气，能量）。"
L["The type of power lost (Mana, Rage, Energy)."] = "失去能量的类型（法力，怒气，能量）。"
L["[Num] CP"] = "[Num]连击点"
L["[Num] CP Finish It!"] = "[Num]连击点 终结技！"


L = LibStub("AceLocale-3.0"):NewLocale("Parrot_Cooldowns", "zhCN")
L["%s Tree"] = "%s系"
L["<Item name>"] = "<物品名称>"
L["<Spell name>"] = "<法术名称>"
L["Click to remove"] = "单击移除"
L["Cooldowns"] = "冷却"
L["Divine Shield"] = "圣盾"
L["Fire traps"] = "火陷阱"
L["Frost traps"] = "冰陷阱"
L["Ignore"] = "忽略"
L["Ignore Cooldown"] = "忽略冷却"
L["Item cooldown ready"] = "物品冷却结束"
L["Judgements"] = "审判"
L["Minimum time the cooldown must have (in seconds)"] = "必备最小冷却时间（秒）"
L["Shocks"] = "震击"
L["Skill cooldown finish"] = "技能冷却完成"
L["Spell ready"] = "法术已准备好"
L["Spell usable"] = "法术可用"
L["The name of the spell or ability which is ready to be used."] = "冷却完成的法术或技能名称。"
L["Threshold"] = "阈值"
L["Traps"] = "陷阱"
L["[[Spell] ready!]"] = "[Spell]冷却完成！"


L = LibStub("AceLocale-3.0"):NewLocale("Parrot_Loot", "zhCN")
L["Loot"] = "拾取"
L["Loot +[Amount]"] = "拾取 +[Amount]"
L["Loot [Name] +[Amount]([Total])"] = "拾取[Name] +[Amount]（[Total]）"
L["Loot items"] = "拾取物品"
L["Loot money"] = "拾取金钱"
L["Soul shard gains"] = "获得灵魂碎片"
L["The amount of gold looted."] = "拾取金钱的数量。"
L["The amount of items looted."] = "物品数量。"
L["The name of the item."] = "物品名称。"
L["The name of the soul shard."] = "灵魂碎片的名称。"
L["The total amount of items in inventory."] = "背包中物品的总量。"


L = LibStub("AceLocale-3.0"):NewLocale("Parrot_TriggerConditions_Data", "zhCN")
L["<Skill name>"] = "<技能名称>"
L["<Sourcename>,<Destinationname>,<Spellname>"] = "<施法者名称>,<目标名称>,<法术名称>"
L["Active talents"] = "启用天赋"
L["Amount"] = "数值"
L["Amount of damage to compare with"] = "伤害数值对比"
L["Amount of health to compare"] = "血量数值对比"
L["Amount of power to compare"] = "能量数值对比"
L["Any"] = "任意"
L["Comparator Type"] = "对比类型"
L["Deathknight presence"] = "死亡骑士灵气"
L["Druid Form"] = "德鲁伊形态"
L["Enemy target health percent"] = "敌对目标血量百分比"
L["Friendly target health percent"] = "友方目标血量百分比"
L["Hostility"] = "敌对"
L["How to compare actual value with parameter"] = "对比实际参数值"
L["In a Group or Raid"] = "在小队或团队"
L["In vehicle"] = "已载具"
L["Incoming block"] = "承受格挡"
L["Incoming cast"] = "承受施法"
L["Incoming crit"] = "承受爆击"
L["Incoming damage"] = "承受伤害"
L["Incoming dodge"] = "承受躲闪"
L["Incoming miss"] = "承受未命中"
L["Incoming parry"] = "承受招架"
L["Lua function"] = "Lua 函数"
L["Maximum target health percent"] = "最大目标血量百分比"
L["Minimum power amount"] = "最小能量数值"
L["Minimum power percent"] = "最小能量百分比"
L["Minimum target health"] = "最小目标血量"
L["Minimum target health percent"] = "最小目标血量百分比"
L["Miss type"] = "未命中类型"
L["Mounted"] = "已坐骑"
L["Not Deathknight presence"] = "没有死亡骑士灵气"
L["Not in Druid Form"] = "没有处于德鲁伊形态"
L["Not in vehicle"] = "未载具"
L["Not in warrior stance"] = "没有处于战士姿态"
L["Not mounted"] = "未坐骑"
L["Outgoing block"] = "产生格挡"
L["Outgoing cast"] = "进行施法"
L["Outgoing crit"] = "产生爆击"
L["Outgoing damage"] = "输出伤害"
L["Outgoing dodge"] = "产生躲闪"
L["Outgoing miss"] = "输出未命中"
L["Outgoing parry"] = "产生招架"
L["Pet health percent"] = "宠物血量百分比"
L["Pet mana percent"] = "宠物法力百分比"
L["Power type"] = "能量类型"
L["Primary"] = "主天赋"
L["Reason for the miss"] = "未命中原因"
L["Secondary"] = "副天赋"
L["Self health percent"] = "自身血量百分比"
L["Self mana percent"] = "自身法力百分比"
L["Successful spell cast"] = "法术施放成功"
L["Target is NPC"] = "目标为 NPC"
L["Target is player"] = "目标为玩家"
L["The unit that attacked you"] = "攻击你的单位"
L["The unit that is affected"] = "受影响单位"
L["The unit that you attacked"] = "你攻击的单位"
L["Type of power"] = "能量类型"
L["Unit"] = "单位"
L["Unit health"] = "单位血量"
L["Unit power"] = "单位能量"
L["Warrior stance"] = "战士姿态"
L["Whether the unit should be friendly or hostile"] = "友好或敌对单位"


L = LibStub("AceLocale-3.0"):NewLocale("Parrot_CombatStatus", "zhCN")
L["+Combat"] = "+战斗"
L["-Combat"] = "-战斗"
L["Combat status"] = "战斗状态"
L["Enter combat"] = "进入战斗"
L["In combat"] = "战斗中"
L["Leave combat"] = "离开战斗"
L["Not in combat"] = "非战斗"
