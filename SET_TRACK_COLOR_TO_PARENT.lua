function Main()
  number = getNumberOfSelectedTracks()
  local i = 0
  while i ~= number do 
    track = getTrack(i)
    folder_info =  getFolderInfo(track)    
    parent_track = getParentTrack()
    
    if parent_track ~= nil then -- check if track has a parent track, otherwise it would throw an error
      color = reaper.GetTrackColor(parent_track)
        
      if color ~= 0 then
          reaper.SetTrackColor(track,color)
      end
    end
    i = i+ 1
  end
end

function getNumberOfSelectedTracks()
  return reaper.CountSelectedTracks(0)
end

function getTrack(i)
  return reaper.GetSelectedTrack(0,i)
end

function getFolderInfo(track)
 return reaper.GetMediaTrackInfo_Value(track, 'I_FOLDERDEPTH') 
end

function getParentTrack()
 return reaper.GetParentTrack(track)
end
Main()
