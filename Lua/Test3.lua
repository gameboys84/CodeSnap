require("Test")

ColorIndex = {
	COLOR_W = 0, -- 万
	COLOR_S = 1, -- 条，索
	COLOR_T = 2, -- 筒
	COLOR_Z	= 3, -- 中发白
	COLOR_F	= 4, -- 风
	COLOR_H	= 5, -- 花牌
}

--判断是否同一花色
function IsSameColor(card1, card2)
	return GetColor(card1) == GetColor(card2)
end

--查询指定牌[1,27]的花色[0,2],[1,9]
function GetColor(cardValue)
	local color, value = NOT_TRUE_CARD, (cardValue-1)%9

	if cardValue >= 1 and cardValue < 10 then
		color = ColorIndex.COLOR_W;		--万字
	elseif cardValue >= 10 and cardValue < 19 then
		color = ColorIndex.COLOR_S;		--条子	
	elseif cardValue >= 19 and cardValue < 28 then
		color = ColorIndex.COLOR_T;		--筒子	
	elseif cardValue >= 28 and cardValue < 31 then
		color = ColorIndex.COLOR_Z;		--中发白	
	elseif cardValue >= 31 and cardValue < 35 then
		color = ColorIndex.COLOR_F;		--风位	
	--else
	--	color = ColorIndex.COLOR_H;			--花牌
	end

	return color, value
end

function FormatMoneyWan(nMoneyNum)
    if nMoneyNum == nil or tonumber(nMoneyNum) == 0 then
        return "0"
    end
    
    nMoneyNum = tonumber(nMoneyNum)
    --local YI = 100000000
    local WAN = 10000
    local strMoneyNum = "";
    -- if nMoneyNum >= YI then
    --     strMoneyNum = string.format("%.1f", nMoneyNum / YI)
    --     strMoneyNum = strMoneyNum .."亿"
    -- else
    if nMoneyNum >= WAN then
        strMoneyNum = string.format("%.0f", nMoneyNum / WAN)
        strMoneyNum = strMoneyNum .."万"
    else
        strMoneyNum = tostring(nMoneyNum)
    end
    
    return strMoneyNum
end

--print(FormatMoneyWan(1134111))
--local str = "QP_M00309273180,CD3BAD"

local tblCoinArenaId = nil
local MahjongTable = {
	--[1] = {idx=1, arenaId=84, baseScore = 1, minScore = 100, name="初级场", baseRule=1},
	--[2] = {idx=2, arenaId=85, baseScore = 1, minScore = 200, name="中级场", baseRule=1},
	--[3] = {idx=3, arenaId=86, baseScore = 1, minScore = 500, name="高级场", baseRule=1},
	
	[1] = {idx=1, arenaId=131, baseScore = 10, minScore = 100, name="定张练习房", baseRule=0},
	[2] = {idx=2, arenaId=132, baseScore = 200, minScore = 4000, name="定张新手房", baseRule=0},
	[3] = {idx=3, arenaId=133, baseScore = 2000, minScore = 40000, name="定张初级房", baseRule=0},
	[4] = {idx=4, arenaId=134, baseScore = 10000, minScore = 200000, name="定张中级房", baseRule=0},
	[5] = {idx=5, arenaId=135, baseScore = 50000, minScore = 1000000, name="定张高级房", baseRule=0},
	[6] = {idx=6, arenaId=136, baseScore = 100000, minScore = 5000000, name="定张专家房", baseRule=0},
	
	[11] = {idx=7, arenaId=137, baseScore = 10, minScore = 100, name="两房练习房", baseRule=1},
	--[12] = {idx=8, arenaId=138, baseScore = 200, minScore = 4000, name="两房新手房", baseRule=1},
	--[13] = {idx=9, arenaId=139, baseScore = 1000, minScore = 20000, name="两房初级房", baseRule=1},
	--[14] = {idx=10, arenaId=140, baseScore = 10000, minScore = 1000000, name="两房中级房", baseRule=1},
	--[15] = {idx=11, arenaId=141, baseScore = 50000, minScore = 5000000, name="两房高级房", baseRule=1},
	--[16] = {idx=6, arenaId=136, baseScore = 100000, minScore = 1000000, name="专家", baseRule=1},
}
function IsCoinArena(arenaId)

	if not tblCoinArenaId then
		local minId,maxId = nil,nil
		for k, v in pairs(MahjongTable) do
			if minId == nil or v.arenaId < minId then
				minId = v.arenaId
			end
			if maxId == nil or v.arenaId > maxId then
				maxId = v.arenaId
			end
		end

		if minId and maxId then
			tblCoinArenaId = {min=minId, max=maxId}
		else
			error("游戏场配置有误")
		end
	end 
	
	return (tblCoinArenaId.min <= arenaId and arenaId <= tblCoinArenaId.max )
end

--print(nil or false)
Utility =
{
	WAN_UNIT = 10000,
	WAN_FORMAT = 100,
	YI_UNIT  = 100000000,
	YI_FORMAT = 1000000,
	
    FORMAT_YI = "亿",
    FORMAT_WAN = "万",
	TIP_CHIP_YI = '%d亿',
	TIP_CHIP_YI_F = '%.2f亿',
	TIP_CHIP_WAN = '%d万',
	TIP_CHIP_WAN_F = '%.2f万',

	getFormatedMoney = function(aMoney,format)
        
		if aMoney >= Utility.YI_UNIT then
			if 0 == aMoney % Utility.YI_UNIT then
                format = format or "%d"
                format = format..Utility.FORMAT_YI
				return string.format(format, math.floor(aMoney / Utility.YI_UNIT))
			else
                format = format or "%d.%d"
                format = format..Utility.FORMAT_YI
				return string.format(format, math.floor(aMoney / Utility.YI_UNIT), math.floor((aMoney % Utility.YI_UNIT) / Utility.YI_FORMAT))
			end
		elseif aMoney >= Utility.WAN_UNIT then
			if 0 == aMoney % Utility.WAN_UNIT then
                format = format or "%d"
                format = format..Utility.FORMAT_WAN
				return string.format(format, math.floor(aMoney / Utility.WAN_UNIT))
			else
                format = format or "%d.%d"
                format = format..Utility.FORMAT_WAN
				return string.format(format, math.floor(aMoney / Utility.WAN_UNIT), math.floor((aMoney % Utility.WAN_UNIT) / Utility.WAN_FORMAT))
			end
		else
			return aMoney
		end
	end;
}

	
dianjuanNum = 1	
DianJuanToCoin = 20000
local content = string.format("您已购买<color=#FFD200FF>%d</color>点券<br/>是否立刻兑换成<color=#FFD200FF>%s</color>金币？", dianjuanNum, Utility.getFormatedMoney(dianjuanNum * DianJuanToCoin))
--print(content)

nScore = nil
--print("ground:" ..tostring(nScore)..", " ..type(nScore))

s = "{\"1\":[\"枫之传奇\",\"http://wx.qlogo.cn/mmopen/SCug0ESSOH8LYDGsotQK6mDDeyplB5DLzdN08qqnjXSad9XDicnic9warhFiaPF8p9wRCgS309co5jKe77bXFPQfzSkKU8DcJlG/0\"]}"
s = string.gsub(s, "\\\\", "\"")
--print(s)

local p = function(value)
	return (value+3)
end

function ttt(func)
	print(func() .." test ttt")
end

--ttt(function(value) return p(2) end)

function CheckPhoneNum(sPhoneNum)
	local strPhoneNumMatch = "^1[73458]%d%d%d%d%d%d%d%d%d$" -- 只能粗略的进行号码检查

	if sPhoneNum ~= nil and string.find(tostring(sPhoneNum), strPhoneNumMatch) then
        return true
	else
		return false
	end
end

--print(CheckPhoneNum(17312341231))

-- 检查验证码是否合法
function CheckVerifyCode(verifyCode)
	local strVerifyCodeMatch = "[^%w]"
	
	print(string.find(tostring(verifyCode), strVerifyCodeMatch))

	if verifyCode ~= nil and string.find(tostring(verifyCode), strVerifyCodeMatch) == nil then
        return true
	else
		--ViewManager.ShowTip(GameTips.BIND_ENTER_VERIFYCODE)
		return false
	end
end

print(CheckVerifyCode("011234a"))

ExchangeTimes=2000 
function UnitExchange(extickets, moneyValue)
	local excoins = ""
	local unit = ""
	local tickets = tonumber(extickets)
	local money = tonumber(moneyValue or 0)

	if tickets * ExchangeTimes < money then
		if money >= 100000000 then
			excoins = money / 100000000
			unit = "亿"
		elseif money >= 10000 then
			excoins = money / 10000
			unit = "万"
		else
			excoins = money
		end
	else
		local coins = tonumber(tickets * ExchangeTimes)
		if coins >= 100000000 then
			excoins = string.format("%.2f", coins / 100000000)
			unit = "亿"
		elseif coins >= 10000 then
			excoins = string.format("%.2f", coins / 10000)
			unit = "万"
		else
			excoins = coins
		end
		--[[
		if tickets >= 50000 then
			excoins = string.format("%.2f", (tickets / 10000) * 2 / 10)
			unit = "亿"
		elseif tickets >= 5 then
			excoins = (tickets * 2.0) / 10
			unit = "万"
		else
			excoins = tickets * 2000
		end
		]]
	end

	return excoins, unit
end

local excoins, unit = UnitExchange(1)
--print(excoins, unit)



--print(os.time())
--print(os.date("*t", 0))
--print(string.format("%02d", 132))
--print(os.date("%Y-%m-%d %X"))
function date2time(date)
    --data = "2017-06-22 17:27:20"
    local Y = string.sub(date, 1, 4)
    local M = string.sub(date, 6, 7)
    local D = string.sub(date, 9, 10)
    local h = string.sub(date, 12, 13)
    local m = string.sub(date, 15, 16)
    local s = string.sub(date, 18, 19)
    return os.time({year=Y, month=M, day=D, hour=h, min=m, sec=s})
end

-- 返回格式：2017-10-25 11:08:42
function now()
    return os.date("%Y-%m-%d %X")
end

--print(os.time())
--print(date2time(now()))
