# ActivFridge

## Contents

|Sections                          |
|----------------------------------|
|[Objectives](#objectives)         |
|[Relationships](#Relationships)   |
|[User_Stories](#User_Stories)     |
|[Resources](#resources)           |

## Objectives

To allow `Users` to effortlessly track the `items` in their `refrigerators`.

Users will be able to maintain an active record of the items going into and out of their refrigerators, receive updates and messages when food items are nearing expiration dates or are low in stock, and be alerted when other users accidentally (or maliciously) steal their food.

## Relationships

User &rarr; Items &larr; Fridges

A `User` has many `Items` // `Items` belong to a `User`

A `Fridge` has many `Items` // `Items` belong to a `Fridge`

A `User` has many `Fridges` through `Items` // A `Fridge` has many `Users` through `Items`

## User Stories

`Users`

- As a user, I should be able to see my refrigerator's current items
- As a user, I should be able to see all things I've bought in the past month (30 days, 90 days)
- As a user, I should be able to add or remove items from fridge
- As a user, I should be able to delete all items from the fridge
- As a user, I should be able to have my personalized pantry

`Fridge`

- As a fridge, I should be able to send an alert to user when someone other than the authorized user is taking an item
- As a fridge, I should remind User when they need to buy more of something (running low)
- As a fridge, I should remind User when their items are nearing expiration date
- As a fridge, I should be able to keep track of each person's inventory (inventory owner)

`Item`

- As an item, I should be able to store the names of every item
- As an item, I should be able to keep track of the expiration dates for each item
- As an item, I should be able to know who bought me, and which fridge I am stored in

`BONUS: RECIPES`

BONUS: Recipes should be able to communicate with Users, Fridges, and Items to guide the User in selecting the ingredients needed to create a dish.

- Recipes should be able to remember all recipes created (both built-in & User inputted)
- Recipes should remove items used up when creating a dish
- Recipes should be able to alert the User when a dish they are trying to make is missing ingredients
- Recipes should be able to adjust ingredient quantities based on serving size

## Resources# ActivFridge
