# ChuckNorrisJokes
iOS Code Challenge - Simple appliation which pulls jokes from the Chuck norris database and presents them to the user.

The application constists of 3 Views:
1. Home view with 2 buttons, one button takes you to the view for a single joke, and the other button takes the user to a view which presents a list of jokes.
2. Single joke view, contains a button which when pressed, initiates a URLsession datatask which gets the joke from the database, formats it, and presents it to the user via a label view, there is also a Back button which takes you back to the Home screen.
3. List of jokes view, contains a table view, which when you scroll to the bottom, the URLsession datatask is initiated, and adds another 10 jokes to the list, an activity indicator and labelView has been added to indicate to the user that the data is being fetched from the server. A back button is also there so the user can navigate back to the home screen.
