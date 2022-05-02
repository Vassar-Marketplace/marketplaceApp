# Vassar Marketplace

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
This is an app for Vassar students to sell items to other Vassar students to keep in their dorms. The user sets up an account with an username and password. Then, they can set their own price and put something up for sale or choose to buy something. Then, the students can arrange how they'll trade the item and both students will have to confirm or the trade will be shown as incomplete.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Sales
- **Mobile:** This app would primarily be used on mobile, but the idea could also be implemented onto a computer.
- **Story:** Let's users sell/buy items by connecting with one another through the app.
- **Market:** Vassar College Students, mostly incoming freshmen and leaving seniors
- **Habit:** This app could be used as often or unoften as the user wanted depending on how often they want to sell/buy items.
- **Scope:** Originally just Vassar students but could expand to other colleges.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

[x] User can log in
[x] User can sign up
* User can view an array of items for sale
* User can add an item to sell
* User can click on an item 
* User can see who is selling the item, as well as their price
* User can see other items someone is selling
* User can buy item
* 

**Optional Nice-to-have Stories**

* Use can chat with the person to negotiate a better deal.

### 2. Screen Archetypes

* Login View Controller
   * User can login
   * User can sign up
* SignUp View Controller
   * User can sign up
* Feed View Controller
    * User can view an array of items for sale
    * User can click on an item 
    * User can see who is selling the item, as well as their price
* Profile View Controller
    * User can see who is selling the item, as well as their price 
    * User can see other items someone is selling
 

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Feed View Contoller
* User Profile
* Post A Photo

**Flow Navigation** (Screen to Screen)

* Login View Controller
    => Feed View Controller
    => SignUp View Controller
    
* SignUp View Controller
    => Login View Controller
    
* Feed View Controller
    => Profile View Controller
    
* Profile View Controller
    => Message Screen
    => Listing View Controller
    
* Listing View Controller
    => Message Screen

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="https://imgur.com/nRsrw16.jpg" width=800><br>

### [BONUS] Digital Wireframes & Mockups
<img src="https://imgur.com/nRsrw16.jpg" width=800><br>

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
#### User

| Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | Name          | String   | Person using the app |
   
#### Post 

| Property      | Type     | Description |
   | ------------- | -------------- | ------------|
   | user          | User           | Person using the app |
   | image         | file data type | Image of the item being sold |
   | caption       | String         | description displayed of item under the image |
   | price         | double         | price the user sets for the item |
   
   

### Networking
- Home Feed Screen
    - (Read/GET) Query all posts where user is author
```
let query = PFQuery(className:"Post")
query.whereKey("author", equalTo: currentUser)
query.order(byDescending: "createdAt")
query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
   if let error = error { 
      print(error.localizedDescription)
   } else if let posts = posts {
      print("Successfully retrieved \(posts.count) posts.")
  // TODO: Do something with posts...
   }
}
```

- Profile Screen
    - (Create/POST) Create a new post object
```
let post = posts[indexPath.section]
        let comments =  (post["comments"] as? [PFObject]) ?? []
        
        
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        let user = post["author"] as! PFUser
        
        cell.usernameLabel.text = user.username
        
        cell.captionLabel.text = post["caption"] as! String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.photoView.af_setImage(withURL: url)
```

    -(Read/GET) Show logged in user posts

```
let query = PFQuery(className:"Post")
query.whereKey("author", equalTo: currentUser)
query.order(byDescending: "createdAt")
query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
   if let error = error { 
      print(error.localizedDescription)
   } else if let posts = posts {
      print("Successfully retrieved \(posts.count) posts.")
  // TODO: Do something with posts...
   }
}
```

- User Screen
    - (Create/POST) Create a new follow to a user
    - (Delete) Unfollowing an existing followed user
    - (Read/GET) Created posts by user

- Sign Up Screen
    - (Create) New user on signup

```
let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
```

- Message Screen
    - (Read/GET) User messages
    - (Update/PUT) Update conversation between users
    - (Create) A new message


Part 2 use cases:
[x] - User is directed to "CreateProfile" screen and click "Done"
[x] - User can logout

Gif of part 2:
<img src="Simulator Screen Recording - iPhone 13 Pro Max - 2022-05-01 at 19.44.01.gif" width=800><br>
