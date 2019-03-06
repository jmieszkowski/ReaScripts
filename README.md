# ReaScripts
Scripts for Reaper DAW

## 1. Set the color of selected tracks from their parent tracks
    Script colors selected tracks to their parent track`s color
   #### How to use:
    Select tracks that you want to color (you don`t have to unselect parent tracks) > run the script 
    
![Alt Text](https://github.com/jmieszkowski/ReaScripts/blob/master/gifs/set_track_color_github.gif)
        


      
      
      

## 2. Create folders from selected tracks based on their names and color them
    Script groups selected tracks according to thier names and colors them
   #### How to use:
    Select tracks that you want to group > run the script
    
![Alt Text](https://github.com/jmieszkowski/ReaScripts/blob/master/gifs/create_folder_github.gif)
#### Customization
##### Adding new words to tables
Basically what the script does, is taking track name and compares to table of strings. Tables are defined at the beginning of the script and can be edited - you can add some word, and if tracks name matches it, he will be added to some group.

```lua
  -- name of the table                                  words in table         
  namesOfDrumTracks = {"kick","snare", "tom","hi hat", "perc", "crash", "OH", "SN", "ride", "hat", "SD", "BD", "HH"}
```
e.g. You want to add tracks with name "KCK" to "DRUMS" folder, but it is not currently implemented. You just have to add "KCK" to the table. 

```lua
  namesOfDrumTracks = {"kick","snare", "tom","hi hat", "perc", "crash", "OH", "SN", "ride", "hat", "SD", "BD", "HH", "KCK"}
```
##### If track name matches any word in table namesOfDrumTracks he will be assigned to drums folder. If track name matches any word in table namesOfVocalTracks he will be assigned to vocal folder etc.
##### Important things:
script does not use full-match, it is more like "does the track name contains this word?".
e.g. if track name is kick12345-abcdefg-159846 it will match with "kick" from namesOfDrumTracks.
So if you add for example "T" as a word in same table, it would not work correctly, because it will match any track name which contains "T". Size of letters does not matter

##### Changing name of created folder
After defining tables, there is a section, where names of folder(parent) tracks are defined.
```lua
  guitarsParentTrackName = "GUITARS"
  stringsParentTrackName = "STRINGS"
  loopsParentTrackName = "LOOPS"
  synthsParentTrackName = "SYNTHS"
  pianosParentTrackName = "PIANOS"
  bassParentTrackName = "BASSES"
  drumsParentTrackName = "DRUMS"
  vocalsParentTrackName = "VOCALS"
```
e.g. if you want to set name of vocals parent track to for example "VOX". You just have to change the string to "VOX".
```lua
     vocalsParentTrackName = "VOX"
```

##### Changing color of the folder
You can change colors of folders in this section. Colors are set in RGB value. You can check RGB value for specific color online. For example: https://www.rapidtables.com/web/color/RGB_Color.html 
```lua
  guitarsColor = reaper.ColorToNative(222,255,11)
  stringsColor = reaper.ColorToNative(255,184,16)
  loopsColor   = reaper.ColorToNative(192,16,255)
  synthsColor  = reaper.ColorToNative(16,255,255)
  pianosColor  = reaper.ColorToNative(255,192,16)
  bassesColor  = reaper.ColorToNative(16,16,255)
  drumsColor   = reaper.ColorToNative(253,0,0)
  vocalsColor  = reaper.ColorToNative(11,255,36)
```


##### Adding your own table
You are able to create your own table, and that means you will have new folder of tracks, which track name matched words from this table. 
###### The syntax is:
```lua
    name_of_the_table = {"word1", "word2", "word3"}
```
e.g. if you want to create the table with names of the coolest guys you know, it would look like this :)
```lua
    theCoolestGuysYouKnow = {"jmieszkowski", "Jedrek", "Mieszkowski"}
```
And then you have to create variable containing name of parent track. Just add it after all parent track names(drumsParentTrackName,vocalsParentTrackName etc.)
```lua
    coolestGuysParentTrackName = "COOLEST GUYS"
```

Now you have to create variable containing color (in RGB) of this folder. In this example its red.
```lua
    coolestGuysColor = reaper.ColorToNative(253,0,0)
```

This is not the end yet. Last think you have to do is actually call function, which creates the folder with your tracks. Just find this section of code and add your code as i did below

```lua  
  createFolder(tracksIndexesThatUserSelected, namesOfStringTracks, stringsParentTrackName, stringsColor)
  createFolder(tracksIndexesThatUserSelected, namesOfLoopsTracks, loopsParentTrackName, loopsColor)
  createFolder(tracksIndexesThatUserSelected, namesOfSynthTracks, synthsParentTrackName, synthsColor)
  createFolder(tracksIndexesThatUserSelected, namesOfPianoTracks, pianosParentTrackName, pianosColor)
  createFolder(tracksIndexesThatUserSelected, namesOfGuitarTracks, guitarsParentTrackName, guitarsColor)
  createFolder(tracksIndexesThatUserSelected, namesOfBassTracks, bassParentTrackName, bassesColor)
  createFolder(tracksIndexesThatUserSelected, namesOfDrumTracks, drumsParentTrackName, drumsColor)
  createFolder(tracksIndexesThatUserSelected, namesOfVocalTracks, vocalsParentTrackName, vocalsColor)
  --            don`t change it!                name of table           name of parent track    color of the folder
  createFolder(tracksIndexesThatUserSelected, theCoolestGuysYouKnow, coolestGuysParentTrackName, coolestGuysColor)
  
```
 And thats all! Enjoy!

     

