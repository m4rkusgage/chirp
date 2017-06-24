# Project Chirp: an iOS Twitter Client: Take home assignment for a job
I was tasked with building a simple Twitter Client, to not only show your skill but also your passion. My passion extends beyond just coding, I like learning and challenging myself, so I wanted to show that part of myself through this as well.

Requirements:
- allow user's to login/logout
- display list of tweets
- allow user's to post a tweet
- on launch, if logged in display list of tweets, automatically showing older ones and query for newer ones
- *no need to connect with API can just mock data
- *no need to make custom controls or design

Now simple tasks, but I want this to be more then just an assignment, I wanna be able to say at the very least, if I dont get the job I can say I learned something. So I worked on this as if I'm on the job. I ran this as if it was a week long sprint. Tasked out the requirements, that you can see as issues, and added in a requirement of my own. Also worked as if I was working on a team, with Git Flow, working on feature branches and merging them in as completed.

Here's my new requirements and assumptions/choices made:
- *for the app to work you must be on a device/simulator that has a twitter account tied to it, as I am only using ACAccount and SLRequest

Requirements:
- Cocoapod Integration
  - used AFNetworking, with their UIKit categories for image downloading
  - used MBProgressHUD

- A Network wrapper
  - *originally gonna build a wrapper around AFNetworking to connect with Twitter REST API, but changed and made a wrapper around Apple's API, SLRequest and working with ACAccount. This made things much easier, with properly authenticating
  - handle login/logout
  - post a tweet
  - save authenticated user data for persistance
  - get home timeline tweets
  - save tweets from timeline
  
- User need's to be able to login/logout
  - the api was already created just needed the UI, for both, a simple button
  
- User need's to be able to see home timeline of tweets
  - *made the choice to only show tweets, no replies, or comments, a simple UI
  - first time log in, see the first 100 recent posts
  - top to bottom, newest to oldest post
  - still logged in when opening up app, see previous posts from last time and query for newer ones
  
- User need's to be able to post a tweet
  - *assumption that a simple text based post would suffice. Didn't include the option to add media to the post
  - a simple tweet only support text right now
  - a simple UI
  - make sure character limit is followed
  - once successfully posted, should show as first tweet on home timeline
  
Assumptions/Choices
- Connect to the API, and not make mock data up, however only connecting through SLRequest and ACAccount, thus for the app to work you must ave a twitter account tied to the device
- support only iPhone and iOS8+ *I don't have to worry about UI for iPads
- support only portrait *I don't have to worry about UI
- in terms of storage for persistence, I've chosen to use UserDefaults and Archiving, much easier to work with plus I feel that Core Data would be alittle over kill for this simple work
  
