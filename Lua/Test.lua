module("Test", package.seeall)

function StrHelper_Split(szFullString, szSeparator)
	local nFindStartIndex = 1
	local nSplitIndex = 1
	local nSplitArray = {}
	
	while true do
	   local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
	   if not nFindLastIndex then
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
		break
	   end
	   nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
	   nFindStartIndex = nFindLastIndex + string.len(szSeparator)
	   nSplitIndex = nSplitIndex + 1
	end

	return nSplitArray
end

function string:split(sep)
	local sep, fields = sep or ",", {}
	local pattern = string.format("([^%s]+)", sep)
	self:gsub(pattern, function(c) table.insert(fields, c) end)
	return fields
end


--[[
local list = StrHelper_Split(str, "+")
for k,v in pairs(list) do
	--print (v)
end
--]]


-- ---------------------------
-- LUA��תΪSTRING
-- {10000,1,1,"NONE"}�ı�ת���ַ�����{10000,1,1,'NONE'}
-- ---------------------------
function TableToStr(t)
	if t == nil then return "" end
	local retstr= "{"

	local i = 1
	for key,value in pairs(t) do
	    local signal = ","
	    if i==1 then
          signal = ""
		end

		if key == i then
			-- ���Ӽ�ֵ

			retstr = retstr..signal..ToStringEx(value)
		else
			if type(key)=='number' or type(key) == 'string' then
				retstr = retstr..signal..'['..ToStringEx(key).."]="..ToStringEx(value)
			else
				if type(key)=='userdata' then
					retstr = retstr..signal.."*s"..TableToStr(getmetatable(key)).."*e".."="..ToStringEx(value)
				else
					retstr = retstr..signal..key.."="..ToStringEx(value)
				end
			end
		end

		i = i+1
	end

 	retstr = retstr.."}"
 	return retstr
end

-------------------------------------------------------------------
-- ͨ�õ�ת��ΪSTRING�ķ�ʽ��Ҳ����ת���ر�
-- ����: {1,2,3} => "{1,2,3}"
--       {a=1,b=2,c=3} => "{a=1,b=2,c=3}"
-------------------------------------------------------------------
function ToStringEx(value)
	if type(value)=='table' then
	   return TableToStr(value)
	elseif type(value)=='string' then
		return "\'"..value.."\'"
	else
	   return tostring(value)
	end
end

function StrToTable(str)
	if str == nil or type(str) ~= "string" then
		--LOGV(2, "StrToTable, params err!")
		return
	end
	
	return loadstring("return " .. str)()
end

-- "{Type=1,PriseInfo=6,GridInfo=5,Mode=4,ActorID=2,RequestSeriNo=3}"
-- "{['Type']=1,['PriseInfo']=6,['GridInfo']=5,['Mode']=4,['ActorID']=2,['RequestSeriNo']=3}"

local t1 = {A=1, B={1, b="strBb", {x='strB2x', y=0.1}}}
--print(t1.B[2].x)


local str1 = TableToStr(t1)
--print(str1)

local t2 = StrToTable(str1)
--print(t2['B'][2].x)


--print(t2['Type'] ..", " ..t2.Type)

--local str111 = "{['Event']='SyncInit',['List']={{['S']=0, ['D']=301989896},{['S']=1, ['D']=285212928},}}"

--local tblTest = "{['nFabaoType']=11, ['nCurExp']=nCurExp,	['nCurBlessness']=nCurBlessness,	['nCurStage']=nCurStage,	['nCurStar']=nCurStar,	['nLookNFeelID']=nLookNFeelID,	['nSkillLevel']={0,0,0,0,0,0}	}"

--local tblFabaoInfo = "{['nFabaoType']=111, ['nCurExp']=222, ['nCurBlessness']=333, ['nCurStage']=444, ['nCurStar']=555, ['nLookNFeelID']=666, ['nSkillLevel']={11,22,33,44,55,66}, }"
--local t = StrToTable(tblTest)


-- 16����תRGBֵ
function HexToRGB(hex)
	hex = tonumber(hex, 16)
	local b = hex % 256
	local g = math.floor((hex % (256*256)) / 256)
	local r = math.floor(hex / (256*256))
	print( string.format("(%d,%d,%d)", r,g,b))
	return r,g,b
end

-- RGBת16����
function RGBToHex(r, g, b)
	local sr = string.format("%02x", tonumber(r))
	local sg = string.format("%02x", tonumber(g))
	local sb = string.format("%02x", tonumber(b))
	local ret = string.upper(sr..sg..sb)
	print(ret)
	return ret
end

-- �Ƕ�ת����
function DegToRad(d)
	local ret = math.rad(d)
	print(ret)
	return ret
end

-- ����ת�Ƕ�
function RadToDeg(r)
	local ret = math.deg(r)
	print(ret)
	return ret
end

-- ��������
function Round(num, idp)
	local mult = 10^(idp or 0)
	local ret = math.floor(num * mult + 0.5) / mult
	print(ret)
	return ret
end

local weekName = { "��", "һ", "��", "��", "��", "��", "��" }
function toDate(dt)
    local temp = dt
	if type(dt) == 'number' then
		temp = os.date("*t", dt)	
	end
	-- ����ʱ�����
	local timezone = 0
	local dtZero = os.date("*t", 0)
	if dtZero.yday == 1 then
		timezone = dtZero.hour
		if dtZero.isdst then
			timezone = timezone - 1
		end
	elseif dtZero.yday == 365 then
		timezone = dtZero.hour - 24
	end
	return ("ʱ��:" ..timezone ..", " ..temp.year .. "��" .. temp.month .. "��" .. temp.day .. "�� " .. temp.hour .. "ʱ" .. temp.min .. "��" .. temp.sec .. "�룬��" .. weekName[temp.wday] .. "����" .. temp.yday .. "�죬���ڱ��" .. tostring(temp.isdst))
end
function printDate(temp)
	print(toDate(temp))
	--print(temp.year, "��", temp.month, "��", temp.day, "��", temp.hour, "ʱ", temp.min, "��", temp.sec, "�룬��", weekName[temp.wday], "����", temp.yday, "�죬���ڱ��", temp.isdst)
end

function printTime(secs)
	local hour = math.floor(secs / 3600)
	local min = math.floor((secs - hour * 3600) / 60)
	local sec = secs % 60
	print( hour .."ʱ" .. min .."��" .. sec .."��")
end

function printTime2(sec)
	local nHours = math.modf(sec / 3600)
	local nMins = math.modf((sec - nHours * 3600) / 60)
	local nSecs = sec % 60	
	
	local text = "%02d:%02d:%02d";
	text = string.format(text, tostring(nHours), tostring(nMins), tostring(nSecs));	
	print(text)
end

function printTable(tbl, tag)
	if tbl == nil then
		print "table is nil"	
		return
	end
	
	local txt = ""
	for k,v in pairs(tbl) do
		txt = txt .. string.format("%s:%s,\n",k,v)
	end
	if tag ~= nil then
		txt = txt .. "tag: "..tag	
	end
	print (txt)		
end

function PrintTable(tab)
    local str = {}

    local function internal(tab, str, indent)
        for k,v in pairs(tab) do
            if type(v) == "table" then
                table.insert(str, indent..tostring(k)..":\n")
                internal(v, str, indent..' ')
            else
                table.insert(str, indent..tostring(k)..": "..tostring(v).."\n")
            end
        end
    end

    internal(tab, str, ' ')
    print(table.concat(str, ' '))
end


--[[
function printTable(tbl)
	if tbl == nil then
		print "table is nil"	
		return
	end
	
	print(table.concat(tbl, ","))
end
--]]

--local ZeroTime  = os.time{year=2014, month=7, day=29, hour=15, min=40, sec=8}
local DiffTime = os.time{year=1970, month=1, day=1, hour=1}
local nowTime = os.time()
--print (nowTime .."    " ..toDate(os.date("*t", nowTime)) )

--printDate(os.date("*t", 1507887231))
--printDate(os.date("*t", 1447443057))
--print(os.clock())


--[[
local ZeroTime  = os.time{year=2000, month=1, day=1, hour=0, min=0, sec=0}  --�κλ�����������ڴ�ʱ��
local ZeroTime1 = os.time{year=2000, month=1, day=2, hour=0, min=0, sec=0}
--print(os.difftime(ZeroTime1, ZeroTime))

local tCurTime = 1381891435 --os.time()
local tmCurTime = os.date("*t", tCurTime)	-- ��ǰʱ��
printDate(tmCurTime)
local tmResetTime = os.date("*t", tCurTime - (tmCurTime.wday-1) * 86400 - tmCurTime.hour * 3600 - tmCurTime.min * 60 - tmCurTime.sec)
printDate(tmResetTime)

print(tmCurTime.wday)
-- ���㵱ǰʱ����
--]]



--[[
--printDate(os.time{year=1970, month=1, day=1, hour=0, min=0,sec=0})
local temp = os.date("*t", os.time())
printDate(temp)


--temp.day = temp.day + 1
temp2 = os.date("*t", os.time{sec=0, min=0, hour=0, day=temp.day, month=temp.month, year=temp.year})

printDate(temp2)

print(os.time(temp) - os.time(temp2))
--print(os.difftime(os.time(temp2), os.time(temp)))
--]]


--[[
���ڷ�Ϊ ���գ��ܣ���
ʱ��� = ��ǰʱ�� - �ϴ�ʱ�� 
if ʱ��� ��һ��������
	if �ϴκ͵�ǰ��ͬһ����
		if �ϴ����ڵڼ������� < ��ǰ���ڵڼ�������
			return true
		elseif �ϴ�����==��ǰ����
			if �ϴν���ʱ�� ���� ��������
				return true
			elseif ���ڻ����
				return false
		
	elseif ����
		if ������������������� == �ϴν���ʱ������
			if �ϴν���ʱ�� ���� ��������
				return true
			elseif ���ڻ����
				return false
		elseif ������������������� == ��ǰʱ������
			return true;

elseif ʱ��� ����һ�������ڣ���������һ�����ڣ�
	return true

--����ʱ��
DAY, WEEK
--]]

--[[
local date = "0-33-1"

local _, _, d, m, y = string.find(date, "(%d+)-(%d+)-(%d+)")
print(d + m + y)
print(d, m, y)       --> 17  7  1990
--]]

function IsRefresh(isWeekly, refreshTime)
	if refreshTime == nil then
		refreshTime = "0-00-00"
	end

	local lastTime = os.date("*t", os.time{year=2013, month=10, day=15, hour=11, min=0,sec=0})
	local nowTime = os.date("*t",os.time())

	printDate(lastTime)
	printDate(nowTime)

	local _, _, wdayRefresh, hourRefresh, minRefresh = string.find(refreshTime, "(%d+)-(%d+)-(%d+)")
	
	-- �ճ�
	if isWeekly == nil or isWeekly == false then
		-- ������������õ�ʱ���
		local todayRefreshTime = os.date("*t", os.time{sec=0, min=minRefresh, hour=hourRefresh, day=nowTime.day, month=nowTime.month, year=nowTime.year})
		printDate(todayRefreshTime)
		if ( os.difftime(os.time(lastTime), os.time(todayRefreshTime)) < 0 and os.difftime(os.time(nowTime), os.time(todayRefreshTime)) >= 0 ) then
			return true
		end
			
	-- �ܳ�
	elseif isWeekly == true and refreshTime ~= nil then
		-- ���ж��Ƿ�Ϊ�����յ��죬�Ǿ��ж��Ƿ��������ʱ��
		if nowTime.wday == (wdayRefresh+1) then
			local todayRefreshTime = os.date("*t", os.time{sec=0, min=minRefresh, hour=hourRefresh, day=nowTime.day, month=nowTime.month, year=nowTime.year})
			printDate(todayRefreshTime)
			if ( os.difftime(os.time(lastTime), os.time(todayRefreshTime)) < 0 and os.difftime(os.time(nowTime), os.time(todayRefreshTime)) >= 0 ) then
				return true
			end
				
		-- ���ڵ�����ж��Ƿ����������
		else
			print("��", wdayRefresh+1)
			if ( lastTime.wday - (wdayRefresh+1) < 0 and nowTime.wday - (wdayRefresh+1) > 0) then
				return true;
			end		
		end
	
	else
		LOGV(LOG_ERROR, "param error")
	end

	return false;
end

--print(IsRefresh(true, "2-11-30"))


--[[
local tblTimeSchedule =
{
    [0000] = "Action1_1",
	[0120] = "Action1_2",
}

--for i=1,#tblTimeSchedule do
--	print(tblTimeSchedule[i])
--end

for k,v in pairs(tblTimeSchedule) do
	print(tblTimeSchedule[k])
end
--]]



function FormatMoneyDot(nMoneyNum)
	if nMoneyNum == nil or tonumber(nMoneyNum) == 0 then
		return "0"
	end
	
	nMoneyNum = tonumber(nMoneyNum)
	local YI = 100000000
	local WAN = 10000
	local strMoneyNum = "";
	if nMoneyNum >= YI then
		strMoneyNum = string.format("%.1f", nMoneyNum / YI)
		strMoneyNum = strMoneyNum .."��"
	elseif nMoneyNum >= WAN then
		strMoneyNum = string.format("%.1f", nMoneyNum / WAN)
		strMoneyNum = strMoneyNum .."��"
	else
		strMoneyNum = tostring(nMoneyNum)
	end
	
	return strMoneyNum
end

function GetTable()
	return {"a", "b", "c"}
end

--PrintTable(GetTable(), "title")
--print("title:"..table.tostring(GetTable()))

--print(FormatMoneyDot(1000))
--print(not "false")
--print(not(false))


--GetTable():tostring()

--PrintTable(tb)
--table.tostring(tb)
--print(tostring(str:split()))


function Md5Sign( strSign )
    return Util.Md5(strSign)
end

function Md5Password( password )
    if password and password ~= "" and #password ~= 32 then
        return Util.Md5(Util.Base64(Util.Md5(string.lower(password))))
    end
    return password
end

function CheckChinese(word)
    local str = word
    if #str >0 and #str /3 %1 == 0 then
        for i=1,#str,3 do
            local temp = string.byte(str,i)
            if temp >= 240 or temp < 224 then
                return false
            end
        end
        -- 228 184 128--233 191 191
        for i=1,#str,3 do
            local temp1 = string.byte(str,i)
            local temp2 = string.byte(str,i+1)
            local temp3 = string.byte(str,i+2)
            if temp1 <228 or temp1 >233 then
                return false
            elseif temp1 == 228 then
                if temp2 < 184 then
                    return false
                elseif temp2 == 184 then
                    if temp3 <128 then
                        return false
                    end
                end
            elseif temp1 == 233 then
                if temp2 >191 then
                    return false
                elseif temp2 == 191 then
                    if temp3 >191 then
                        return false
                    end
                end
            end
        end
        return true
    end
end

--����˺����ַ��Ƿ�Ϸ�,�Ϸ�����true�����򷵻�false
--����ٶ��Ϸ����˺���ֻ��������ĸ�����ֹ���
function CheckAccountChars(name)
    if not name or name=="" then return false end
    if CheckChinese(name) then return false end
    for k = 1, #name do
        local c = string.byte(name,k)
        if c then
            if (c>=48 and c<=57) or (c>= 65 and c<=90) or (c>=97 and c<=122) then  
                --������˵���ַ���ok��
            else
                return false
            end
        end
    end  
    return true
end

-- �����֤���Ƿ�Ϸ�
function CheckVerifyCode(verifyCode)
	if verifyCode == nil or #verifyCode < 1 then
		ViewManager.ShowTip(GameTips.PHONE_VERIFYCODE_NONE)
		return false
	end

	local strVerifyCodeMatch = "[^%d]" -- �жϷ�����
	if string.find(tostring(verifyCode), strVerifyCodeMatch) == nil then
        return true
	else
		ViewManager.ShowTip(GameTips.PHONE_VERIFYCODE_FORMAT_ERROR)
		return false
	end
end

-- ����ֻ����Ƿ�Ϸ�
function CheckPhoneNum( sPhoneNum )
	if sPhoneNum == nil or #sPhoneNum < 1 then
		ViewManager.ShowTip(GameTips.BIND_ENTER_PHONE)
		return false
	end

	local strPhoneNumMatch = "^1[34578]%d%d%d%d%d%d%d%d%d$" -- �ж�11λ������13/14/15/17/18��ͷ
	if string.find(tostring(sPhoneNum), strPhoneNumMatch) then
        return true
	else
		ViewManager.ShowTip(GameTips.BIND_PHONE_FORMAT_ERROR)
		return false
	end
end

-- ��������ַ
function CheckEmail( email)
	if email == nil or #email < 1 then
		ViewManager.ShowTip(GameTips.BIND_ENTER_EMAIL)
		return false
	end

	if string.match(email, "[%w]+%@[%w]+%.com$") then -- �ж��� xx@xx.com ��ʽ
		return true
	else
		ViewManager.ShowTip(GameTips.BIND_EMAIL_FORMAT_ERROR)
		return false
	end
end
