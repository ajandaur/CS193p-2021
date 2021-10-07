### COMPLETED!  

# Required Tasks

- [X] Get the Memorize game working as demonstrated in lectures 1 and 2. Type in all the code. Do not copy/paste from anywhere.
    
- [X] You can remove the ⊖ and ⊕ buttons at the bottom of the screen.
	
- [X] Add a title “Memorize!” to the top of the screen.

- [X] Add at least 3 “theme choosing” buttons to your UI, each of which causes all of the cards to be replaced with new cards that contain emoji that match the chosen theme. You can use Vehicles from lecture as one of the 3 themes if you want to, but you are welcome to create 3 (or more) completely new themes.
	
- [X] The number of cards in each of your 3 themes should be different, but in no case fewer than 8.
    
	
- [X] The cards that appear when a theme button is touched should be in an unpredictable (i.e. random) order. In other words, the cards should be shuffled each time a theme button is chosen.
    
	
- [X] The theme-choosing buttons must include an image representing the theme and text describing the theme stacked on top of each other vertically.
    
	
- [X] The image portion of each of the theme-choosing buttons must be created using an SF Symbol which evokes the idea of the theme it chooses (like the car symbol and the Vehicles theme shown in the Screenshot section below).
    
	
- [X] The text description of the theme-choosing buttons must use anoticeably smaller font than the font we chose for the emoji on the cards.
    
	
- [X] Your UI should work in portrait or landscape on any iPhone. This probably will not require any work on your part (that’s part of the power of SwiftUI), but be sure to experiment with running on different simulators in Xcode to be sure.

Extra Credit

Here are some additional ways to challenge yourself ...

1. [X] Make a random number of cards appear each time a theme button is chosen.The function Int.random(in: Range<Int>) can generate a random integer in any range, for example, let random = Int.random(in: 15...75) would generate a random integer between 15 and 75 (inclusive). Always show at least 4 cards though.

2. [X] Try to come up with some sort of equation that relates the number of cards in the game to the width you pass when you create your LazyVGrid’s GridItem(.adaptive(minimum:maximum:)) such that each time a theme button is chosen, the LazyVGrid makes the cards as big as possible without having to scroll.
    
    For example, if 8 cards are shown, the cards should be pretty big, but if 24 cards are shown, they should be smaller. The cards should still have our 2/3 aspect ratio.
    
    It doesn’t have to be perfect either (i.e. if there are a few extreme combinations of device size (e.g. iPod touch for example) and number of cards, punting to scrolling is okay). The goal is to make it noticeably better than always using 65 is.
    
    It’s probably impossible to pick a width that makes the cards fit just right in both Portrait and Landscape, so optimize for Portrait and just let your ScrollView kick in if the user switches to Landscape.
    
    Your “equation” can include some if-else’s if you want (i.e. it doesn’t have to be a single purely mathematical expression) but you don’t want to be special-casing every single number from 4 to 24 cards or some such. Try to keep your “equation” code efficient (i.e. not a lot of lines of code, but still works pretty well in the vast majority of situations).
    
    The type of the arguments to GridItem(.adaptive(minimum:maximum:)) is a CGFloat. It’s just a normal floating point number that we use for drawing. You know what kind of results 65 gives you, so you’re going to have to experiment with other numbers up and down from there.
    
    We haven’t covered functions yet, but you likely would want to put your calculation in a func. If so, you’d have to figure that out on your own. Your reading assignment covers func syntax in detail of course, but you probably just want something like this: func widthThatBestFits(cardCount: Int) -> CGFloat.
    
    When you do this, it becomes even more obvious that we really want the font we use to draw the emoji to scale with the size of the cards. We’ll learn to do that next week or the week after, so there’s nothing to do on that front this week.
    
    Finally, what you’ll really come to understand is that the “equation” we need is actually dependent on the size of the area we have to draw the cards in. That’s also something we’ll find out more about in lecture in the next week or so.