
import Restaurant from "../Models/restaurantModel.js";


export const getRestaurants = async (req, res) => {
    try {
        let query = {};

        if (req.query.search) {
            query.name = req.query.search;
        }
        if (req.query.location) {
            query.location = req.query.location;
        }

        // find restaurants with the name and location specified 
        let restaurants = await Restaurant.find(query);

        if (!restaurants) {
            return res.status(404).json({ msg: "no packages for today!", data: [] });
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