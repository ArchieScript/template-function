








local function SnapToGridMIDI(take,timeProj);
    local grid_ME,swing = reaper.MIDI_GetGrid(take);
    local item = reaper.GetMediaItemTakeInfo_Value(take,'P_ITEM');
    local itpos = reaper.GetMediaItemInfo_Value(item,'D_POSITION');
    local beats,_,_,tpos_beats = reaper.TimeMap2_timeToBeats(0,timeProj);
    if swing == 0 then;
	   if(beats%grid_ME)<(grid_ME/2)then;
		  out_beatpos=tpos_beats-(beats%grid_ME);
	   else;
		  out_beatpos=tpos_beats-(beats%grid_ME)+grid_ME;
	   end;
	   local out_pos = reaper.TimeMap2_beatsToTime(0,out_beatpos);
	   local out_ppq = reaper.MIDI_GetPPQPosFromProjTime(take,out_pos);
	   return out_pos,out_ppq;
    else;         
	   local midival=0.5+0.25*swing;
	   local checkval=0.5*(beats%(grid_ME*2))/grid_ME;
	   if checkval<midival then;
		  if checkval<0.5*midival then;
			 out_beatpos=tpos_beats-(beats%grid_ME);
		  else;
			 if swing<0 then;
				out_beatpos=tpos_beats-(beats%grid_ME)+grid_ME*midival*2;
			 else;
				out_beatpos=tpos_beats-(beats%grid_ME)+grid_ME*swing/2;
				if checkval%midival<0.5 then out_beatpos=out_beatpos+grid_ME end;
			 end;
		  end;
	   else;
		  if checkval<midival+0.5*(1-midival)then;
			 out_beatpos=tpos_beats-(beats%grid_ME)+grid_ME*0.5*swing;
		  else;
			 out_beatpos = tpos_beats-(beats%grid_ME)+grid_ME;
		  end;
	   end;
	   local out_pos = reaper.TimeMap2_beatsToTime(0,out_beatpos);
	   local out_ppq = reaper.MIDI_GetPPQPosFromProjTime(take,out_pos);
	   return out_pos,out_ppq;
    end;
end;


local midiEditor = reaper.MIDIEditor_GetActive();
local take = reaper.MIDIEditor_GetTake(midiEditor);
GGG1,TTT = SnapToGridMIDI(take,reaper.GetCursorPosition());
