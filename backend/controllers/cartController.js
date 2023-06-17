

import Cart from '../Models/cartModel.js';
import Hotel from '../Models/hotelModel.js';
import Destination from "../Models/destinationModel.js";
import Restaurant from '../Models/restaurantModel.js';

// Add a hotel to the cart
export const addHotelToCart = async (req, res) => {
  try {
    const { hotelId } = req.body;

    // Check if the hotelId is valid and exists in the Hotel collection
    const hotel = await Hotel.findById(hotelId);
    if (!hotel) {
      return res.status(400).json({ message: 'Invalid hotelId' });
    }

    const cart = await Cart.findOneAndUpdate(
      {},
      { $addToSet: { hotels: hotelId } }, // Use $addToSet to prevent duplicates
      { new: true }
    );
    res.status(200).json(cart);
  } catch (error) {
    res.status(500).json({ message: 'Failed to add hotel to cart' });
  }
};

// Add a restaurant to the cart
export const addRestaurantToCart = async (req, res) => {
  try {
    const { restaurantId } = req.body;

    // Check if the restaurantId is valid and exists in the Restaurant collection
    const restaurant = await Restaurant.findById(restaurantId);
    if (!restaurant) {
      return res.status(400).json({ message: 'Invalid restaurantId' });
    }

    const cart = await Cart.findOneAndUpdate(
      {},
      { $addToSet: { restaurants: restaurantId } }, // Use $addToSet to prevent duplicates
      { new: true }
    );
    res.status(200).json(cart);
  } catch (error) {
    res.status(500).json({ message: 'Failed to add restaurant to cart' });
  }
};

// Add a destination to the cart
export const addDestinationToCart = async (req, res) => {
  try {
    const { destinationId } = req.body;

    // Check if the destinationId is valid and exists in the Destination collection
    const destination = await Destination.findById(destinationId);
    if (!destination) {
      return res.status(400).json({ message: 'Invalid destinationId' });
    }

    const cart = await Cart.findOneAndUpdate(
      {},
      { $addToSet: { destinations: destinationId } }, // Use $addToSet to prevent duplicates
      { new: true }
    );
    res.status(200).json(cart);
  } catch (error) {
    res.status(500).json({ message: 'Failed to add destination to cart' });
  }
};

// Remove a hotel from the cart
export const removeHotelFromCart = async (req, res) => {
  try {
    const { hotelId } = req.body;

    const cart = await Cart.findOneAndUpdate(
      {},
      { $pull: { hotels: hotelId } },
      { new: true }
    );
    res.status(200).json(cart);
  } catch (error) {
    res.status(500).json({ message: 'Failed to remove hotel from cart' });
  }
};

// Remove a restaurant from the cart
export const removeRestaurantFromCart = async (req, res) => {
  try {
    const { restaurantId } = req.body;

    const cart = await Cart.findOneAndUpdate(
      {},
      { $pull: { restaurants: restaurantId } },
      { new: true }
    );
    res.status(200).json(cart);
  } catch (error) {
    res.status(500).json({ message: 'Failed to remove restaurant from cart' });
  }
};

// Remove a destination from the cart
export const removeDestinationFromCart = async (req, res) => {
  try {
    const { destinationId } = req.body;

    const cart = await Cart.findOneAndUpdate(
      {},
      { $pull: { destinations: destinationId } },
      { new: true }
    );
    res.status(200).json(cart);
  } catch (error) {
    res.status(500).json({ message: 'Failed to remove destination from cart' });
  }
};

// Get a list of hotels in cart
export const getHotels = async (req, res) => {
  try {
    let cart = await Cart.findOne(); // Assuming there's only one cart for the user

    if (!cart) {
      // Create a new cart if it doesn't exist
      cart = new Cart();
      await cart.save();
    }

    const hotelIds = cart.hotels;
    const hotels = await Hotel.find({ _id: { $in: hotelIds } });

    res.status(200).json(hotels);
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch hotels from the cart.' });
  }
};

// Get a list of destinations in cart
export const getDestinations = async (req, res) => {
  try {
    let cart = await Cart.findOne(); // Assuming there's only one cart for the user

    if (!cart) {
      // Create a new cart if it doesn't exist
      cart = new Cart();
      await cart.save();
    }

    const destinationIds = cart.destinations;
    const destinations = await Destination.find({ _id: { $in: destinationIds } });

    res.status(200).json(destinations);
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch destinations from the cart.' });
  }
};

// Get a list of restaurants in cart
export const getRestaurants = async (req, res) => {
  try {
    let cart = await Cart.findOne(); // Assuming there's only one cart for the user

    if (!cart) {
      // Create a new cart if it doesn't exist
      cart = new Cart();
      await cart.save();
    }

    const restaurantIds = cart.restaurants;
    const restaurants = await Restaurant.find({ _id: { $in: restaurantIds } });

    res.status(200).json(restaurants);
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch restaurants from the cart.' });
  }
};
