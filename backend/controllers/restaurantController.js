
import Restaurant from "../Models/restaurantModel.js";


export const getRestaurants = async (req, res) => {
    try {
        let query = {};

        if (req.query.name) {
            query.name = { $regex: req.query.name, $options: 'i' };
        }
        if (req.query.location) {
            query.location = { $regex: req.query.location, $options: 'i' };
        }

        // find restaurants with the name and location specified 
        let restaurants = await Restaurant.find(query);

        if (restaurants.length == 0) {
            return res.status(404).json({ msg: "No such Restaurant found!", data: [] });
        }

        return res.status(200).json({ data: restaurants });

    } catch (error) {
        res.status(400).json({ msg: error.message });
    }
}


export const getRestaurant = async (req, res) => {

    const restaurant_id = req.params.id
    try {
        const rest = await Restaurant.findById(restaurant_id);
        if (!rest) {
            return res.status(404).json({ msg: "Sorry this restaurant no longer exists.", data: null });
        }
        return res.status(200).json({ data: rest });
    } catch (error) {
        res.status(400).json({ msg: error.message });
    }
}

export const addHotel = async (req, res) => {
    try {
        const hotel = await Hotel.create(req.body)
        res.status(200).json({ success: true, data: hotel })
    } catch (error) {
        res.status(500).json({ msg: error.message })
    }
};