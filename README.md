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

* User can log in
* User can sign up
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
[Add table of models]
### Networking
- [Add list of network requests by screen]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
