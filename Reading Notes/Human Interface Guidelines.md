# Interface Essentials 
-  UIKit is adaptable and allows for many different features across the iOS ecoosystem
-  It is broken down in three main categories: 
	1. Bars
	2. Views 
	3. Controls
	# Launching 
	- This experience is pretty important considering it is the first thing a user sees 
	- The reason you have a launch screen is to show users that your app is fast and responsive 
	- Make sure to launch in the right orientation
	- **Don't ask for setup information at the very beginning**
	- **Don't show in-app licensing agreements and disclaimers**
	- This is kind of a given, but make sure you restore the previous state when your app launches
	- Don't ask for ratings to quickly or too often
# Onboarding
- Don't include licensing details or complex setup 
- Get to the action quickly, don't take too long for the startup to happen
- Look out for places where users might need help from the developers 
- Make it fun and discoverable 
# Loading 
- **At the MINIMUM, make sure you have an activity spinner to communicate that something is happening**
-  Show content ASAP and don't make people wait 
-  If you wanna get deep in it, show some fun animations or educate the user while they are waiting
# Modality 
- What is Modality -> a design technique that presents content in a temporary mode that's separate from the user's previous current context and requires an explicit action to exit
- Some of these include:
## Sheet 
- This presentation style is very much like a car covering the initial view 
- You can dismiss the card by swiping down from teh top of the screen, swiping down from anywhere on the screen when card content is scrolled to the top, tapping a button
- **Use a sheet for nonimmersive modal content that doesn't enable a complex task**
## Fullscreen
- **Use this for immersive content like videos, photos, or camera views**
## General Advice
- Use modality when it makes sense to.. do it when it's critical to focus people's attention on making a choice or **performing a task that's different from their current task!**
- Use alerts when you absolutely need to, such as when something goes really wrong! 
- Don't try to create a heirarch of views becaus then most people will probably get lost 
- Always have a button to dismiss a modal view 
- Avoid data loss by having people confirm before closing a modal view 
- Don't display a card that appears on top of a popover 
- Choose a modal transition that makes sense for the app and also make sure your transitions are consistent! 
# Navigation 
- Different apps will have different navigation systems 
- Make sure the path is easy to follow and logical -> give users one path to each screen. If they need to see a screen in multiple contexts, consider using an action sheet, alert, popover, or modal view 
- Design a system where it makes it fast and easy to get content 
- Use touch gestures to make it easy to move through the interfact without friction! -> let people swipe from side of the screen to return to the previous screen
# Accessing User Data 
- Privacy is very important when accessing User Data
## Requesting Access Permission
- You must ask for permission before using user data or protected resources 
- Only request permission when your app needs access to the data or resource
- Request permission at launch only when teh data or resource is necessary for your app to function
- **Never precede the system-provided alert with custom messaging that could confuse or mislead people.** People sometimes tap quickly to dismiss alerts without reading them. A custom messaging screen that takes advantage of such behaviors to influence choices will lead to rejection by App Store Review.
# Settings