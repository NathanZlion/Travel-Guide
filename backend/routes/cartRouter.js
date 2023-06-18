
import express from 'express';

import {
    addHotelToCart,
    addRestaurantToCart,
    addDestinationToCart,
    removeHotelFromCart,
    removeRestaurantFromCart,
    removeDestinationFromCart,
    getCart,
    clearCart,
} from '../controllers/cartController.js';

const cartRouter = express.Router();

cartRouter.get('/', getCart);
cartRouter.delete('/', clearCart);
cartRouter.post('/addHotel', addHotelToCart);
cartRouter.post('/addRestaurant', addRestaurantToCart);
cartRouter.post('/addDestination', addDestinationToCart);
cartRouter.post('/removeHotel', removeHotelFromCart);
cartRouter.post('/removeRestaurant', removeRestaurantFromCart);
cartRouter.post('/removeDestination', removeDestinationFromCart);

export default cartRouter;
