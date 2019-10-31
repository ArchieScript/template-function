

-- CopyInput_FocusedFX_Pin   -- копировать маршрутизацию с сфокусированого плагина
-- PasteInput_FocusedFX_Pin  -- вставить скопированную маршрутизацию в сфокусированый плагин
-- CopyOutput_FocusedFX_Pin
-- PasteOutput_FocusedFX_Pin





    -------------------------------------------------
    local function CopyInput_FocusedFX_Pin(NameScript,persist);--section
    
	   local retval,tracknumber,itemnumber,fxnumber = reaper.GetFocusedFX();
	   local track = reaper.GetTrack(0,tracknumber-1);
	   if not track then return -1 end;
	   
	   local t = {};
	   if retval > 0 then;
		  reaper.DeleteExtState(NameScript,"CopyInputPlugin",persist);
		  if itemnumber < 0 then;
			 ----
			 local _,inputPins,_ = reaper.TrackFX_GetIOSize(track,fxnumber);
			 for i = 1,inputPins do;
				local retval, high32 = reaper.TrackFX_GetPinMappings(track,fxnumber,0,i-1);
				t[#t+1]= "{".. i-1 .. "&" .. retval.."}";
			 end;
		  else;
			 local take_numb = fxnumber >> 16;
			 local fx_number = fxnumber & 65535;
			 local Item = reaper.GetTrackMediaItem(track,itemnumber);
			 local Take = reaper.GetTake(Item,take_numb);
			 local _,inputPins,_ = reaper.TakeFX_GetIOSize(Take,fx_number);
			 
			 for i = 1,inputPins do;
				local retval, high32 = reaper.TakeFX_GetPinMappings(Take,fx_number,0,i-1);
				t[#t+1]= "{".. i-1 .. "&" .. retval.."}";
			 end; 
		  end;
		  t = table.concat(t);
		  reaper.SetExtState(NameScript,"CopyInputPlugin",t,persist);--NameScript
	   else;
		  return -1;
	   end;
    end;
    -------------------------------------------------
    
    
    
    -------------------------------------------------
    local function PasteInput_FocusedFX_Pin(NameScript,clean,persist);--section
	   local retval,tracknumber,itemnumber,fxnumber = reaper.GetFocusedFX();
	   local track = reaper.GetTrack(0,tracknumber-1);
	   if not track then return -1 end;
	   
	   if retval > 0 then;
		  
		  if itemnumber < 0 then;
			 local t = reaper.GetExtState(NameScript,"CopyInputPlugin");
			 if t ~= "" then;
				for var in t:gmatch("{.-}") do;
				    local InPlug,Channel_beat = var:match("{(.-)&(.-)}");
				    reaper.TrackFX_SetPinMappings(track,fxnumber,0,InPlug,Channel_beat,0);
				end;
				if clean == true then;
				    reaper.DeleteExtState(NameScript,"CopyInputPlugin",persist);
				end;
			 end;
		  else;
			 ----
			 local take_numb = fxnumber >> 16;
			 local fx_number = fxnumber & 65535;
			 local Item = reaper.GetTrackMediaItem(track,itemnumber);
			 local Take = reaper.GetTake(Item,take_numb);
			 
			 local t = reaper.GetExtState(NameScript,"CopyInputPlugin");
			 if t ~= "" then;
				for var in t:gmatch("{.-}") do;
				    local InPlug,Channel_beat = var:match("{(.-)&(.-)}");
				    reaper.TakeFX_SetPinMappings(Take,fx_number,0,InPlug,Channel_beat,0);
				end;
				if clean == true then;
				    reaper.DeleteExtState(NameScript,"CopyInputPlugin",persist);
				end;
			 end;
			 ----  
		  end;
	   else;
		  return -1;
	   end;
    end;
    -------------------------------------------------
    
    
    
    -------------------------------------------------
    local function CopyOutput_FocusedFX_Pin(NameScript,persist);--section
    
	   local retval,tracknumber,itemnumber,fxnumber = reaper.GetFocusedFX();
	   local track = reaper.GetTrack(0,tracknumber-1);
	   if not track then return -1 end;
	   
	   local t = {};
	   if retval > 0 then;
		  reaper.DeleteExtState(NameScript,"CopyOutputPlugin",persist);
		  if itemnumber < 0 then;
			 ----
			 local _,_,outputPins = reaper.TrackFX_GetIOSize(track,fxnumber);
			 for i = 1,outputPins do;
				local retval, high32 = reaper.TrackFX_GetPinMappings(track,fxnumber,1,i-1);
				t[#t+1]= "{".. i-1 .. "&" .. retval.."}";
			 end;
		  else;
			 local take_numb = fxnumber >> 16;
			 local fx_number = fxnumber & 65535;
			 local Item = reaper.GetTrackMediaItem(track,itemnumber);
			 local Take = reaper.GetTake(Item,take_numb);
			 local _,_,outputPins = reaper.TakeFX_GetIOSize(Take,fx_number);
			 
			 for i = 1,outputPins do;
				local retval, high32 = reaper.TakeFX_GetPinMappings(Take,fx_number,1,i-1);
				t[#t+1]= "{".. i-1 .. "&" .. retval.."}";
			 end; 
		  end;
		  t = table.concat(t);
		  reaper.SetExtState(NameScript,"CopyOutputPlugin",t,persist);--NameScript
	   else;
		  return -1;
	   end;
    end;
    -------------------------------------------------
    
    
    
    
    -------------------------------------------------
    local function PasteOutput_FocusedFX_Pin(NameScript,clean,persist);--section
	   local retval,tracknumber,itemnumber,fxnumber = reaper.GetFocusedFX();
	   local track = reaper.GetTrack(0,tracknumber-1);
	   if not track then return -1 end;
	   
	   if retval > 0 then;
		  
		  if itemnumber < 0 then;
			 local t = reaper.GetExtState(NameScript,"CopyOutputPlugin");
			 if t ~= "" then;
				for var in t:gmatch("{.-}") do;
				    local OutPlug,Channel_beat = var:match("{(.-)&(.-)}");
				    reaper.TrackFX_SetPinMappings(track,fxnumber,1,OutPlug,Channel_beat,0);
				end;
				if clean == true then;
				    reaper.DeleteExtState(NameScript,"CopyOutputPlugin",persist);
				end;
			 end;
		  else;
			 ----
			 local take_numb = fxnumber >> 16;
			 local fx_number = fxnumber & 65535;
			 local Item = reaper.GetTrackMediaItem(track,itemnumber);
			 local Take = reaper.GetTake(Item,take_numb);
			 
			 local t = reaper.GetExtState(NameScript,"CopyOutputPlugin");
			 if t ~= "" then;
				for var in t:gmatch("{.-}") do;
				    local OutPlug,Channel_beat = var:match("{(.-)&(.-)}");
				    reaper.TakeFX_SetPinMappings(Take,fx_number,1,OutPlug,Channel_beat,0);
				end;
				if clean == true then;
				    reaper.DeleteExtState(NameScript,"CopyOutputPlugin",persist);
				end;
			 end;
			 ----  
		  end;
	   else;
		  return -1;
	   end;
    end;
    -------------------------------------------------
