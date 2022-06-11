if SERVER then return end

CDRAW = CDRAW or {}

local circle_cache = {}

function CDRAW.DrawCircle(x,y,radius,seg)
	local segstr = x..y..radius..seg
	if circle_cache[segstr] then
		surface.DrawPoly(circle_cache[segstr])
	else
		local cir = {}
		cir[#cir+1] = {x=x,y=y,u=0.5,v=0.5}
		for i = 0, seg do
			local a = math.rad((i/seg)*-360)
			cir[#cir+1] = {x=x+math.sin(a)*radius,y=y+math.cos(a)*radius,u=math.sin(a)/2+0.5,v=math.cos(a)/2+0.5}
		end
		local a = math.rad(0)
		cir[#cir+1] = {x=x+math.sin(a)*radius,y=y+math.cos(a)*radius,u=math.sin(a)/2+0.5,v=math.cos(a)/2+0.5}
		circle_cache[segstr] = cir
		surface.DrawPoly(cir)
	end
end

function CDRAW.DrawRect(col,x,y,w,h)
	x, y = math.Round(x), math.Round(y)
	w, h = math.Round(w), math.Round(h)
	surface.SetDrawColor(col.r,col.g,col.b,col.a)
	surface.DrawRect(x,y,w,h)
end

function CDRAW.GetTextSize(...)
	local aye = {...}
	surface.SetFont(aye[1])
	local legx, legy = 0, 0
	for i = 2, #aye do
		if isstring(aye[i]) then
			local xd, yd = surface.GetTextSize(tostring(aye[i]))
			legx = legx + xd
			legy = legy > yd and legy or yd
		end
	end
	return legx, legy
end

function CDRAW.DrawText(...)
	local aye = {...}
	surface.SetFont(aye[1])
	aye[2], aye[3] = math.Round(aye[2]), math.Round(aye[3])
	local oldx, oldy = 0, 0
	for i = 4, #aye do
		if istable(aye[i]) then
			surface.SetTextColor(aye[i].r,aye[i].g,aye[i].b,aye[i].a)
		else
			surface.SetTextPos(aye[2]+oldx,aye[3])
			surface.DrawText(aye[i])
			local _ox, _oy = surface.GetTextSize(aye[i])
			oldx, oldy = oldx+_ox, oldy+_oy
		end
	end
end

function CDRAW.DrawNiceText(Col,Off,Font,Text)
	local sw, sh = CDRAW.GetTextSize(Font,Text)
	CDRAW.DrawText(Font..'_blur',-sw/2,-sh/2-Off,Col,Text)
	CDRAW.DrawText(Font,-sw/2,-sh/2-Off,Col,Text)
end

return CDRAW