# Backend | Server side

**Models :**
1.  destination
2.  hotel
3.  restaurant


**Controllers :**
1.  destination
2.  hotel
3.  restaurant

All Api Urls To Use
---
Hotels
- get all hotels
	- http://localhost:5000/api/hotel   get all hotels

- get hotel filtered by location
	- http://localhost:5000/api/hotel?location=addis 

- get hotel filtered by hotel name
	- http://localhost:5000/api/hotel?name=capital 

- get hotel filtered by hotel name and location
	- http://localhost:5000/api/hotel?name=capital&location=addis 

```
There is an api to get hotel by id but I dont see the use of it. We can pass the hotel object as a constructor to the hotel detail page.
```

---
Restaurants
- get all hotels
	- http://localhost:5000/api/restaurant   

- get hotel filtered by location
	- http://localhost:5000/api/restaurant?location=addis 

- get hotel filtered by hotel name
	- http://localhost:5000/api/restaurant?name=capital 

- get hotel filtered by hotel name and location
	- http://localhost:5000/api/restaurant?name=capital&location=addis 

```
There is an api to get restaurant by id but I dont see the use of it. We can pass the Restaurant object as a constructor to the Restaurant detail page.
```

Destination
- get all destinations
	- http://localhost:5000/api/destination   

- get hotel filtered by location
	- http://localhost:5000/api/destination?location=addis 

- get hotel filtered by destination name
	- http://localhost:5000/api/destination?name=capital 

- get hotel filtered by destination name and location
	- http://localhost:5000/api/destination?name=capital&location=addis 

```
There is an api to get destination by id but I dont see the use of it. We can pass the destination object as a constructor to the destination detail page.
```
