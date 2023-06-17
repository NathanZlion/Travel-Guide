
import express from 'express';

import {
    addHotelToCart,
    addRestaurantToCart,
    addDestinationToCart,
    removeHotelFromCart,
    removeRestaurantFromCart,
    removeDestinationFromCart,
    getHotels,
    getDestinations,
    getRestaurants,
} from '../controllers/cartController.js';

const cartRouter = express.Router();

cartRouter.post('/addHotel', addHotelToCart);
cartRouter.post('/addRestaurant', addRestaurantToCart);
cartRouter.post('/addDestination', addDestinationToCart);
cartRouter.post('/removeHotel', removeHotelFromCart);
cartRouter.post('/removeRestaurant', removeRestaurantFromCart);
cartRouter.post('/removeDestination', removeDestinationFromCart);
cartRouter.get('/Hotels', getHotels);
cartRouter.get('/Destinations', getDestinations);
cartRouter.get('/Restaurants', getRestaurants);

export default cartRouter;
