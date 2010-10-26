
AutoHideKeyboard
================

AutoHideKeyboard is a small utility that automatically hides a virtual keyboard, Axiotron Quickclicks, after a preset delay. There are two versions of the applet, an older AppleScript version and a new version  using AppleScriptobjC. Both versions may be easily adjusted to provide autohiding for any window of any scriptable application.

AppleScript Version: KeyboardAutoHide
=====================================

KeyboardAutoHide is an AppleScript applet that automatically hides the Axiotron Quickclicks keyboard after a preset delay. The keyboard will return to its normal (unhid) location if you hover the mouse/pen briefly over the keyboard's hiding location. (Hence it is important that, when hid, the Keyboard is partially visible.) 

When you first open KeyboardAutoHide, a preference dialog appears asking you to set the delay time before the keyboard hides. If you do not want the keyboard to automatically hide, but, instead, only want it to hide when you click the window close button, enter zero for the delay time. The dialog box also asks you to position the the keyboard where you want it to hide. If you want to adjust either the delay or the hiding location at a later time, you can access this preference dialog box while the applet is running.

When the app is running, you may use and position the keyboard any way you like. By using or by just hovering the mouse/pen over the keyboard you keep it from hiding. If you are not using it for the preset line delay or if you close the keyboard by clicking the red close button, it will move to its hiding place. Once it is in its hiding location, briefly hovering the cursor over the keyboard causes it the to return to its previous unhid location.

If you want access to the preference dialog box to adjust the time delay or hiding location, hide the keyboard and then hover the pen/mouse over the hiding place and hold it there for a count of four. The preference dialog will then appear.

You can download the applet from a [post at Modbookish][KeyboardAutoHide post], a forum focused on the Axiotron Modbook.

AppleScriptObjC Version: AutoHideKeyboard
=========================================

The AutoHideKeyboard version works a little differently from its AppleScript cousin. When you launch AutoHideKeyboard, you are presented with a control panel in which you can adjust the auto hide delay time and the fading behavior of the applet when it is not the frontmost app. 

![ControlPanel][]

This panel is surrounded by four rectangular buttons, which are used to unhide the keyboard window. 

Begin by setting the hide delay and fade behavior and then resize and move the panel to the desired hiding location. You might shrink it to a little flower of buttons and locate the panel along an edge so that only one button is visible.

![FlowerButtons][]  ![SideButton][]

Alternatively, you might shrink it to a single button and position it where you are working.

![SingleButton][]

Then either hit a button or close the keyboard window, and the applet will activate. Thereafter, if the keyboard is not used for the preset delay time or is closed, it will shrink and turn into the little control panel. Then, if you hit one of the control panel's buttons, it will zoom up and become the keyboard window again.

Note that since AutoHideKeyboard is written in AppleScriptObjC, it will only work in Macs running Snow Leopard. 

Downloads
---------

A binary download is available from a forum [post at Modbookish][AutoHideKeyboard post].

How to Adapt This Applet to AutoHide Other Windows
--------------------------------------------------

The first few lines of the file `AutoHideKeyboardAppDelegate.applescript` include:

     property windowAppName : "Axiotron Quickclicks"
     property windowName : "Axiotron Quickclicks"

Changing the first of these to the name of another scriptable application and changing the second to the name of a window in that application is enough to cause AutoHideKeyboard to auto hide a different window of a different app. More interesting things are possible, like multiple window hiding, if you alter the section of the code marked off by:

     ---------- AppleScripting the window we want to AutoHide ----------

Credits and License
===================

Both KeyboardAutoHide and AutoHideKeyboard were written by [Eric Nitardy][ericn] (© 2010) and are made available under the terms in the `license.txt` file.

[KeyboardAutoHide post]: http://modbookish.lefora.com/2010/05/19/auto-hide-for-axiotron-quickclicks-virtual-keyboar/
[ControlPanel]: http://dl.dropbox.com/u/6347985/Modbookish/Downloads/AutoHideKeyboard/ControlPanel.png
[FlowerButtons]: http://dl.dropbox.com/u/6347985/Modbookish/Downloads/AutoHideKeyboard/FlowerButtons.png
[SideButton]: http://dl.dropbox.com/u/6347985/Modbookish/Downloads/AutoHideKeyboard/SideButton.png
[SingleButton]: http://dl.dropbox.com/u/6347985/Modbookish/Downloads/AutoHideKeyboard/SingleButton.png
[AutoHideKeyboard post]: http://modbookish.lefora.com/2010/10/26/an-improved-auto-hide-for-axiotron-quickclicks/
[ericn]: http://modbookish.lefora.com/members/ericn/
 