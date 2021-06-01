# RaffleChallenge

The Raffle Challenge app allows users to create, view, and participate in raffles. After creating a raffle, use your secret to select a winner

### Raffle API (https://raffle-fs-app.herokuapp.com)
The data for this app is retrieved through the use of several endpoints provided by the API, and URLSession to make the appropriate request method (GET, POST, PUT). Fetching all of the raffles, it's participants, signing up for a raffle, creating a raffle, and selecting a winner for a raffle are all completed through the API. 

### MVC vs MVVM
When originally working on this project, it was built with MVC allowing me to quickly build a prototype in a familiar fashion. After the general framework was laid out, including UI (via Storyboard), I was able to refactor to MVVM. This provided the distinct advantage of allowing me to use a single data type, to pass around the view controllers which contained all of the properties I needed without having to constantly make network calls to get my data.

### Screenshots
Coming soon

### Known Bugs
- Dates don't display correctly 
- Number of participants in the collection view doesn't display correctly

### Future Implementations
- Notify winner by email
- Sort options when viewing all raffles (each with ascending/descending options): 
  - Creation Date
  - Number of participants
  - Winner Selected / No Winner
- Confetti animation when a winner is selected
- Provide participant with their ID for lookup
- First time user experience to onboard a user
- More Unit/UI Testing for better code coverage
