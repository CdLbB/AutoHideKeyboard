--
--  AutoHideKeyboardAppDelegate.applescript
--  AutoHideKeyboard
--
--  Created by Eric Nitardy on 10/19/10.
--  Copyright 2010. 
--
global autoHideTimer, appIsStarting, cancelPerformSelectorNotVisible

property windowAppName : "Axiotron Quickclicks"
property windowName : "Axiotron Quickclicks"
property hideTimerUnit : 0.5
property screenHeight : 800 -- get this and test it with a multimonitor setup

property autoHideDelay : 12
property maxAutoHideDelay : 20 -- max value is effectively "Forever"
property hiddenPanelFrame : {origin:{x:131, y:318}, size:{|width|:240, height:110}}
property fadePanel : true

script AutoHideKeyboardAppDelegate
	property parent : class "NSObject"
	
	property CursorWhere : class "CursorWhere"
	property NSScreen : class "NSScreen"
	
	---------- User interface code ---------------------------------------------	
	property NSColor : class "NSColor"
	
	property controlPanel : missing value
	property delaySlider : missing value
	property fadeRadioButton : missing value
	property opaqueRadioButton : missing value
	property quitButton : missing value
	-------------------------------------------------------------------------------
	
	---------- AppleScripting the window we want to AutoHide ----------	
	on makeWindowVisible()
		try
			--tell application windowAppName to show Keyboard
			tell application windowAppName to set visible of window windowName to true
			return true
		on error
			return false
		end try
	end makeWindowVisible
	
	on makeWindowNotVisible()
		try
			--tell application windowAppName to hide Keyboard
			tell application windowAppName to set visible of window windowName to false
			return true
		on error
			return false
		end try
	end makeWindowNotVisible
	
	on getWindowVisibility()
		tell application windowAppName
			return visible of window windowName
		end tell
	end getWindowVisibility
	
	on getWindowBounds()
		tell application windowAppName
			set rawBounds to bounds of window windowName
		end tell
		set point1 to {x:item 1 of rawBounds, y:item 2 of rawBounds}
		set point2 to {x:item 3 of rawBounds, y:item 4 of rawBounds}
		return {point1, point2}
	end getWindowBounds
	
	on noWindowPresent() -- Error for no app or window found
		tell application "System Events"
			activate
			display alert "No window " & "\"" & windowName & "\" of" & return & "application " & "\"" & windowAppName & "\"" & " present." message "The window this app is setup to AutoHide cannot be found." as warning
		end tell
		current application's NSApp's terminate_(me) --Quit
	end noWindowPresent
	-------------------------------------------------------------------------------
	
	--------------- Bounds in global coordinates (pt, pt) ---------------
	---------- changed to screen coordinates (position, size) ---------
	on convertBoundsToFrame(theBounds)
		set thePosition to {x:x of item 1 of theBounds, y:screenHeight - (y of item 2 of theBounds)}
		set theSize to {|width|:(x of item 2 of theBounds) - (x of item 1 of theBounds), height:(y of item 2 of theBounds) - (y of item 1 of theBounds)}
		return {thePosition, theSize}
	end convertBoundsToFrame
	
	on makePanelNotVisible()
		current application's NSApp's hide_(me)
	end makePanelNotVisible
	
	on makePanelVisible()
		current application's NSApp's unhide_(me)
	end makePanelVisible
	
	on makePanelZoomToWindow()
		set windowBounds to getWindowBounds()
		set windowFrame to convertBoundsToFrame(windowBounds)
		set hiddenPanelFrame to controlPanel's frame
		controlPanel's setFrame_display_animate_(windowFrame, true, true)
		
		makeWindowVisible()
		performSelector_withObject_afterDelay_("makePanelNotVisible", missing value, 0.005)
	end makePanelZoomToWindow
	
	on makePanelUnZoomFromWindow()
		set windowBounds to getWindowBounds()
		set windowFrame to convertBoundsToFrame(windowBounds)
		controlPanel's setFrame_display_(windowFrame, false)
		
		makePanelVisible()
		makeWindowNotVisible()
		performSelector_withObject_afterDelay_("unZoomPanel", missing value, 0.005)
	end makePanelUnZoomFromWindow
	on unZoomPanel()
		controlPanel's setFrame_display_animate_(hiddenPanelFrame, true, true)
	end unZoomPanel
	
	------------------------------- First Idle loop ------------------------------
	-------------------------------------------------------------------------------
	on loopForWindowVisible()
		if getWindowVisibility() is true then
			log autoHideTimer
			----- Abort if app just started or autoHideDelay is forever ----- 
			if appIsStarting is true or autoHideDelay is maxAutoHideDelay * 2 then
				performSelector_withObject_afterDelay_("loopForWindowVisible", missing value, hideTimerUnit)
				return
			end if
			
			set windowBounds to getWindowBounds()
			if CursorWhere's isCursorOverBoundsFrom_To_(item 1 of windowBounds, item 2 of windowBounds) is 0 then -- Cursor IS NOT inside window bounds
				
				set autoHideTimer to autoHideTimer + hideTimerUnit
				if autoHideTimer ≥ autoHideDelay then -- hideTimer timed out, UnZoom
					log "timeout"
					log autoHideTimer
					makePanelUnZoomFromWindow()
					-- Switch to Other idle loop --
					performSelector_withObject_afterDelay_("loopForWindowNotVisible", missing value, 6 * hideTimerUnit)
					return
				end if
			else -- Cursor IS inside window bounds
				set autoHideTimer to 0.0 -- cursor over window, reset autoHideTimer
			end if
			
			performSelector_withObject_afterDelay_("loopForWindowVisible", missing value, hideTimerUnit)
			return
			
		else -- Window Not Visible
			if appIsStarting is true then -- activate the app when window closed
				set appIsStarting to false
				set hiddenPanelFrame to controlPanel's frame
			end if
			log "not vis- unzoom"
			log autoHideTimer
			makePanelUnZoomFromWindow()
			-- Switch to Other idle loop --
			performSelector_withObject_afterDelay_("loopForWindowNotVisible", missing value, 6 * hideTimerUnit)
			return
		end if
	end loopForWindowVisible
	
	----------------------------- Second Idle loop -----------------------------
	-------------------------------------------------------------------------------	
	on loopForWindowNotVisible()
		if cancelPerformSelectorNotVisible is true then -- Abort and switch to Other loop
			set cancelPerformSelectorNotVisible to false
			-- Switch to Other idle loop --
			performSelector_withObject_afterDelay_("loopForWindowVisible", missing value, 0.005)
			return
		end if
		
		if getWindowVisibility() is true then
			set hiddenPanelFrame to controlPanel's frame
			log "Became vis vanish"
			log autoHideTimer
			makePanelNotVisible()
			set autoHideTimer to 0.0 -- window visible, reset autoHideTimer
			-- Switch to Other idle loop --
			performSelector_withObject_afterDelay_("loopForWindowVisible", missing value, hideTimerUnit)
			return
		end if
		
		performSelector_withObject_afterDelay_("loopForWindowNotVisible", missing value, 5 * hideTimerUnit)
	end loopForWindowNotVisible
	
	on buttonPushed_(sender)
		if appIsStarting is true then -- activate the app when button pushed
			set appIsStarting to false
		else
			set cancelPerformSelectorNotVisible to true
			-- This does what "my cancelPreviousPerformRequestsWithTarget_(me)"
			-- is suppose to do. I couldn't get that Cocoa method to work.
		end if
		makePanelZoomToWindow()
		set autoHideTimer to 0.0 -- window visible, reset autoHideTimer 
	end buttonPushed_
	
	
	on applicationWillFinishLaunching_(aNotification)
		
		-- Automatically detect primary display screen height
		set primaryScreen to (NSScreen's screens)'s objectAtIndex_(0)
		set screenHeight to height of |size| of ((primaryScreen's frame) as record)
		
		set appIsStarting to true
		set cancelPerformSelectorNotVisible to false
		set autoHideTimer to 0.0
		set hiddenPanelFrame to controlPanel's frame
		--makePanelUnZoomFromWindow()
		--makePanelZoomToWindow()
		performSelector_withObject_afterDelay_("loopForWindowVisible", missing value, hideTimerUnit)
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
	-------------------------------------------------------------------------------
	---------- User interface code from here down -------------------------
	-------------------------------------------------------------------------------	
	on awakeFromNib()
		if makeWindowVisible() is false then noWindowPresent() -- Error!
		controlPanel's setStyleMask_(72) -- no title bar, no button, but resize corner present
		controlPanel's setMovableByWindowBackground_(true)
		controlPanel's setLevel_(128) -- a level above Axiotron Quickscript
		controlPanel's setBackgroundColor_(NSColor's colorWithDeviceHue_saturation_brightness_alpha_(0.15, 0.0, 0.85, 1.0))
		controlPanel's setCollectionBehavior_(1) -- Panel present on all Desktop Spaces
		
		quitButton's highlight_(true)
		
		-- Last three tick marks of delay slider are max, 1.5*max, and forever( 2*max) --
		if autoHideDelay < maxAutoHideDelay then
			delaySlider's setDoubleValue_(autoHideDelay)
		else if autoHideDelay < maxAutoHideDelay * 1.5 then
			delaySlider's setDoubleValue_(maxAutoHideDelay - 2)
		else if autoHideDelay < maxAutoHideDelay * 2 then
			delaySlider's setDoubleValue_(maxAutoHideDelay - 1)
		else
			delaySlider's setDoubleValue_(maxAutoHideDelay)
		end if
		
		
		if fadePanel is true then -- set radio button to reflect fadePanel value
			fadeRadioButton's setIntValue_(1)
			opaqueRadioButton's setIntValue_(0)
		else
			fadeRadioButton's setIntValue_(0)
			opaqueRadioButton's setIntValue_(1)
		end if
	end awakeFromNib
	
	on changeDelaySlider_(sender) -- Last three tick marks are long, longer, and forever.
		set autoHideDelay to sender's doubleValue()
		if autoHideDelay = maxAutoHideDelay - 2 then
			set autoHideDelay to maxAutoHideDelay
		else if autoHideDelay = maxAutoHideDelay - 1 then
			set autoHideDelay to maxAutoHideDelay * 1.5
		else if autoHideDelay = maxAutoHideDelay then
			set autoHideDelay to maxAutoHideDelay * 2
		end if
		log autoHideDelay
	end changeDelaySlider_
	
	on applicationDidBecomeActive_(aNotification) -- when panel unZooms controls stay visible! how to fix?
		controlPanel's setAlphaValue_(1.0) -- Unfade panel
		delaySlider's setHidden_(false) -- Unhide controls
	end applicationDidBecomeActive_
	
	on applicationDidResignActive_(aNotification)
		if fadeRadioButton's intValue() is 1 then -- Fade panel
			controlPanel's setAlphaValue_(0.55)
			set fadePanel to true
		else
			set fadePanel to false
		end if
		delaySlider's setHidden_(true) -- Hide controls
	end applicationDidResignActive_
	
	on windowDidUpdate_(aNotification)
		set theFrame to (controlPanel's frame) as record
		if (height of |size| of theFrame) < 100 or (|width| of |size| of theFrame) < 110 then
			delaySlider's setHidden_(true) -- Hide controls
		else
			delaySlider's setHidden_(false) -- Unhide controls
		end if
	end windowDidUpdate_
	
	on quitApplication_(sender)
		current application's NSApp's terminate_(me) --Quit
	end quitApplication_
	
end script
