----------------------------------------------------------------------------------------------------------------
--This script was written by Eric Nitardy (©2010). It is available from The Modbookish and may be modified and redistributed provided appropriate credits are given, and they accompany the script.

-- The script was designed to work with with the virtual keyboard app, "Axiotron Quickclicks", but with a few strategic adjustments might be used to auto-hide any chosen window of any application. 

-- The script uses a small, very simple Unix utility, "mouse-location", that determines the mouse cursor location. Please look at the accompanying "mouse-location.c" source file for more information.
----------------------------------------------------------------------------------------------------------------

global winHide, returnPosition, hideBox, idleTime, hideCount, hideCountMax, configCount, configCountMax, mouseLocPath, autoHide

property theApp : "Axiotron Quickclicks"
property theWinName : "Axiotron Quickclicks"

property hidePosition : {261, 765}
property firstRun : 0
property hideDelay : 12
property idleTime : 0.35



on WakeWindow()
	tell application "Axiotron Quickclicks" --theApp
		Hide Keyboard
		Show Keyboard
		delay 0.01
	end tell
end WakeWindow

--- Find the index of window with name: theWinName ---
--------------------------------------------------------------------
on FindWindow()
	tell application "Axiotron Quickclicks" --theApp
		set winNum to 0
		try
			repeat with i from 1 to count of windows
				try
					if name of window i is theWinName then
						set winNum to i
						exit repeat
					end if
				end try
			end repeat
		on error
			tell application "System Events"
				activate
				display alert "The application \"" & theApp & "\" is not AppleScriptable." as warning
				quit
			end tell
		end try
		if winNum is 0 then
			activate
			tell application "System Events"
				display alert "There is no window with name:  " & return & "\"" & theWinName & "\"" as warning
				quit
			end tell
			return 0
		end if
	end tell
	return winNum
end FindWindow


--- Configure window hiding location and time delay before hiding ---
---------------------------------------------------------------------------------
on Config()
	set returnPosition to MoveWindow(hidePosition)
	tell application "Axiotron Quickclicks" --theApp
		set hideBox to bounds of window theWinName
	end tell
	set frontmostApp to short name of (info for (path to frontmost application))
	set frontmostApp to "System Events"
	if firstRun is 0 or firstRun is 2 then
		try
			tell application frontmostApp
				activate
				display dialog "Enter delay in seconds before " & theWinName & "  autohides." & return & return & "and" & return & return & "Position " & theWinName & " in its hiding location." default answer (hideDelay as string) buttons {"Quit", "Cancel", "OK"} default button 3 cancel button 2
			end tell
			set theResult to result
			if button returned of theResult is "OK" then
				tell application "Axiotron Quickclicks" --theApp
					set hidePosition to (position of window theWinName)
					set hideBox to bounds of window theWinName
				end tell
				set hideDelay to (text returned of theResult) as integer
				
			else if button returned of theResult is "Quit" then
				MoveWindow(returnPosition)
				return 0
			end if
		end try
	end if
	
	MoveWindow(returnPosition)
	if hideDelay = 0 then
		set autoHide to false
	else
		set autoHide to true
		--tell application "System Events" to display dialog "hi"
		set hideCountMax to (hideDelay / (idleTime + 0.1)) as integer
		if hideCountMax < configCountMax then set hideCountMax to configCountMax - 2
	end if
	set configCount to 0
	set hideCount to 0
	
	return 1
end Config

-------------------------------------------------
------ Main initialization of variables ------
-------------------------------------------------
on run
	
	set mouseLocPath to quoted form of (POSIX path of (path to resource "mouse-location"))
	set winHide to false
	
	set idleTime to 0.5
	set hideCount to 0
	
	set configCount to 0
	set configCountMax to 6
	
	WakeWindow()
	set winNum to FindWindow()
	if winNum is 0 then
		quit
		return
	end if
	
	if firstRun is 2 then set firstRun to 1
	if Config() is 0 then
		quit
		return
	end if
	set firstRun to 2
	
	return idleTime
end run


----------------------------------------------------------------
------ Idle handler. Runs every idleTime seconds ------
----------------------------------------------------------------
on idle
	if winHide is false then
		
		--- If window is not hiding ---
		-----------------------------------
		if WindowVisible() then
			
			----- Window Visible ----
			if autoHide is true then
				if MouseInWindow() is true then
					set hideCount to 0
				else
					set hideCount to hideCount + 1
					
					if hideCount ³ hideCountMax then
						set hideCount to 0
						set returnPosition to MoveWindow(hidePosition)
						WakeWindow()
						tell application "Axiotron Quickclicks" --theApp
							set hideBox to bounds of window theWinName
						end tell
						set winHide to true
					end if
				end if
			end if
			if configCount > 1 then
				if MouseInHideBox() is true then
					set configCount to configCount + 1
					
					if configCount ³ configCountMax then
						if Config() is 0 then
							quit
							return
						end if
					end if
					
				else
					set configCount to 0
				end if
			end if
			
			----- Window Not Visible ----	
		else
			set hideCount to 0
			set returnPosition to MoveWindow(hidePosition)
			WakeWindow()
			tell application "Axiotron Quickclicks" --theApp
				set hideBox to bounds of window theWinName
			end tell
			set winHide to true
		end if
		
		--- If window is hiding ---
		------------------------------	
	else
		if MouseInHideBox() is true then
			if configCount is 0 then
				set configCount to 1
			else
				set configCount to 2
				WakeWindow()
				MoveWindow(returnPosition)
				set winHide to false
			end if
		else
			set configCount to 0
			try
				tell application "Axiotron Quickclicks" --theApp
					set hideBox to bounds of window theWinName
					set hidePosition to position of window theWinName
				end tell
			end try
			
		end if
		
	end if
	return idleTime
end idle

--- Make window visable before quitting ---
---------------------------------------------------
on quit
	WakeWindow()
	MoveWindow(returnPosition)
	set firstRun to 1
	continue quit
	return
end quit


----- Animation of window move -----
--------------------------------------------
on MoveWindow(lastPosition)
	tell application "Axiotron Quickclicks" --theApp
		
		
		set theDifference to {0, 0}
		set theRate to {0, 0}
		set theStart to {0, 0}
		set thePlace to {0, 0}
		set thePosition to position of window theWinName
		if lastPosition is thePosition then
			set thePosition to {(item 1 of lastPosition) + 10, (item 2 of lastPosition) + 10}
		end if
		set theSteps to 0
		repeat with i from 1 to 2
			set item i of theDifference to (item i of thePosition) - (item i of lastPosition)
			if item i of theDifference > theSteps then set theSteps to item i of theDifference
			if -(item i of theDifference) > theSteps then set theSteps to -(item i of theDifference)
		end repeat
		set theSteps to (theSteps / 100) as integer
		if theSteps = 0 then set theSteps to 1
		repeat with i from 1 to 2
			set item i of theRate to ((item i of theDifference) / theSteps)
		end repeat
		
		repeat with i from 1 to 2
			set item i of theStart to (item i of lastPosition) + theSteps * (item i of theRate)
		end repeat
		log {thePosition, lastPosition, theDifference, theRate, theStart, theSteps}
		repeat with i from 0 to theSteps
			set item 1 of thePlace to ((item 1 of theStart) - (item 1 of theRate) * i) as integer
			set item 2 of thePlace to ((item 2 of theStart) - (item 2 of theRate) * i) as integer
			set position of window theWinName to thePlace
		end repeat
		
	end tell
	return thePosition
end MoveWindow


---- Use "mouse-location" to locate cursor ----
------------------------------------------------------
on MouseLocate()
	set mouseS to do shell script mouseLocPath
	set xCoor to ((items 1 thru 5 of mouseS) as text) as integer
	set yCoor to ((items 7 thru 11 of mouseS) as text) as integer
	return {xCoor, yCoor}
end MouseLocate

---- Determine if cursor is over window ----
---------------------------------------------------
on MouseInWindow()
	set {xCoor, yCoor} to MouseLocate()
	tell application "Axiotron Quickclicks" --theApp
		set {xLow, yLow, xHi, yHi} to bounds of window theWinName
	end tell
	if xLow ² xCoor and xCoor ² xHi then
		if yLow - 15 ² yCoor and yCoor ² yHi then return true
	end if
	return false
	
end MouseInWindow

----- Determine if cursor is over window hide location -----
---- Note that window may not be visible while hiding ----
--------------------------------------------------------------------
on MouseInHideBox()
	set {xCoor, yCoor} to MouseLocate()
	set {xLow, yLow, xHi, yHi} to hideBox
	
	if xLow + 10 ² xCoor and xCoor ² xHi - 10 then
		if yLow - 15 ² yCoor and yCoor ² yHi - 10 then return true
	end if
	return false
end MouseInHideBox

----- Determine if window is visible -----
-----------------------------------------------
on WindowVisible()
	tell application "Axiotron Quickclicks" --theApp
		return visible of window theWinName
	end tell
end WindowVisible