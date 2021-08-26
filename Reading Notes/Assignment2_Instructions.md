### IN PROGRESS

# Required Tasks
- [X] Get the Memorize game working as demonstrated in lectures 1 through 4. Type in all the code. Do not copy/paste from anywhere. 
- [X] If you’re starting with your assignment 1 code, remove your theme-choosing buttons and (optionally) the title of your game.
- [X] Add the formal concept of a “Theme” to your Model. A Theme consists of a name for the theme, a set of emoji to use, a number of pairs of cards to show, and an appropriate color to use to draw the cards.
- [X] At least one Theme in your game should show fewer pairs of cards than the number of emoji available in that theme.
- [X] If the number of pairs of emoji to show in a Theme is fewer than the number of emojis that are available in that theme, then it should not just always use the first few emoji in the theme. It must use any of the emoji in the theme. In other words, do not have any “dead emoji” in your code that can never appear in a game.
- [X] Never allow more than one pair of cards in a game to have the same emoji on it
- [X] If a Theme mistakenly specifies to show more pairs of cards than there are emoji available, then automatically reduce the count of cards to show to match the count of available emoji.
- [X] Support at least 6 different themes in your game.
- [X] A new theme should be able to be added to your game with a single line of code.
- [X] Add a “New Game” button to your UI (anywhere you think is best) which begins a brand new game.
- [X] A new game should use a randomly chosen theme and touching the New Game button should repeatedly keep choosing a new random theme.
- [X] The cards in a new game should all start face down.
- [X] The cards in a new game should be fully shuffled. This means that they are not in any predictable order, that they are selected from any of the emojis in the theme (i.e. Required Task 5), and also that the matching pairs are not all side-by-side like they were in lecture (though they can accidentally still appear side-by-side at random).
- [X] Show the theme’s name in your UI. You can do this in whatever way you think looks best.
- [X] Keep score in your game by penalizing 1 point for every previously seen card that is involved in a mismatch and giving 2 points for every match (whether or not the cards involved have been “previously seen”). See Hints below for a more detailed explanation. The score is allowed to be negative if the user is bad at Memorize.
- [X] Display the score in your UI. You can do this in whatever way you think looks best.

# Extra Credit
We try to make Extra Credit be opportunities to expand on what you’ve learned this week. Attempting at least some of these each week is highly recommended to get the most out of this course.

If you choose to tackle an Extra Credit item, mark it in your code with comments so your grader can find it. 

- [X] When your code creates a Theme, allow it to default to use all the emoji available in the theme if the code that creates the Theme doesn’t want to explicitly specify how many pairs to use. This will require adding an init or two to your Theme struct. 
- [X] Allow the creation of some Themes where the number of pairs of cards to show is not a specific number but is, instead, a random number. We’re not saying that every Theme now shows a random number of cards, just that some Themes can now be created to show a random number of cards (while others still are created to show a specific, pre-determined number of cards). 
- [X] Support a gradient as the “color” for a theme. Hint: fill() can take a Gradient as its argument rather than a Color. This is a “learning to look things up in the documentation” exercise. 
- [  ] Modify the scoring system to give more points for choosing cards more quickly. For example, maybe you get max(10 - (number of seconds since last card was chosen), 1) x (the number of points you would have otherwise earned or been penalized with). (This is just an example, be creative!). You will definitely want to familiarize yourself with the Date struct.