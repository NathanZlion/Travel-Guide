

import Cart from '../Models/cartModel.js';

// Add a hotel to the cart
export const addHotelToCart = async (req, res) => {
    try {
        const { hotelId } = req.body;

        const cart = await Cart.findOneAndUpdate(
            {},
            { $addToSet: { hotels: hotelId } }, // Use $addToSet to prevent duplicates
            { new: true }
        ).populate('hotels').populate('destinations').populate('restaurants');
        res.status(200).json({ data: cart });
    } catch (error) {
        res.status(500).json({ message: 'Failed to add hotel to cart' });
    }
};

// Add a restaurant to the cart
export const addRestaurantToCart = async (req, res) => {
    try {
        const { restaurantId } = req.body;

        const cart = await Cart.findOneAndUpdate(
            {},
            { $addToSet: { restaurants: restaurantId } }, // Use $addToSet to prevent duplicates
            { new: true }
        ).populate('hotels').populate('destinations').populate('restaurants');
        res.status(200).json({ data: cart });
    } catch (error) {
        res.status(500).json({ message: 'Failed to add restaurant to cart' });
    }
};

// Add a destination to the cart
export const addDestinationToCart = async (req, res) => {
    try {
        const { destinationId } = req.body;

        const cart = await Cart.findOneAndUpdate(
            {},
            { $addToSet: { destinations: destinationId } }, // Use $addToSet to prevent duplicates
            { new: true }
        ).populate('hotels').populate('destinations').populate('restaurants');
        res.status(200).json({ data: cart });
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
        ).populate('hotels').populate('destinations').populate('restaurants');
        res.status(200).json({ data: cart });

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
        ).populate('hotels').populate('destinations').populate('restaurants');
        res.status(200).json({ data: cart });
    } catch (error) {
        res.status(500).json({ message: 'Failed to remove restaurant from cart' });
    }
};

// Remove a destination from the cart
export const removeDestinationFromCart = async (req, res) => {
    try {
        console.log("You were here", req.body);
        const { destinationId } = req.body;
        console.log("You were here", destinationId);

        const cart = await Cart.findOneAndUpdate(
            {},
            { $pull: { destinations: destinationId } },
            { new: true }
        ).populate('hotels').populate('destinations').populate('restaurants');

        res.status(200).json({ data: cart });
    } catch (error) {
        res.status(500).json({ message: 'Failed to remove destination from cart' });
    }
};

// Get the cart with populated hotel, destination, and restaurant details
export const getCart = async (req, res) => {
    try {
        const cart = await Cart.findOne({}).populate('hotels').populate('destinations').populate('restaurants');

        res.status(200).json({ data: cart });
    } catch (error) {
        res.status(500).json({ message: 'Failed to get cart' });
    }
}
