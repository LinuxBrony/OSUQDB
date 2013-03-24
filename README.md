OSUQDB
======

Ohio State University Quote Databse version 0.6 alpha

About
-----
This project is based on some of the [EDUbash](http://edu.tjbash.org/) pages.
It's a simple Ruby on Rails web app for users to submit quotes, have admins
approve them, and then be able to search through the quotes. More features are
planned as time goes on (and I manage to think of them).

Status
------
This isn't even close to done, please don't fork it/submit pull requests until
it hits 1.0, this is just a preview right now.

What works:
 - Quotes can be added
 - Quotes can be displayed in different orders (Browse, Latest, Random)
   - Browse and latest have different pages
 - Clicking the name of a Quote will give you a link to ti
 - Posts can be upvoted and downvoted
   - Upvoting logs your IP and only lets you vote every 48 hrs per quote
   - You can change your vote
 - Limited CSS

What doesn't:
 - There's no links at the bottom to let you navigate between pages
 - You have to manually approve quotes from the console
 - No static pages explaining what it is or news or anything
 - Missing kitten (or other cute animal) links at the bottom
 - Stuff I haven't thought of
