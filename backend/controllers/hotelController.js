

import Hotel from "../Models/hotelModel.js";


export const getHotels = async (req, res) => {
    try {
        let query = {};

        if (req.query.name) {
            query.name = { $regex: req.query.name, $options: 'i' };
        }

        if (req.query.location) query.location = { $regex: req.query.location, $options: 'i' };

        console.log(query);

        let Hotels = await Hotel.find(query);
        

        // no hotel matches by that filter found
        if (Hotels.length == 0) return res.status(404).json({ msg: "No such hotel found!", data: [] });


        return res.status(200).json({ data: Hotels });

    } catch (error) {
        res.status(400).json({ msg: `${error.message}` });
    }
}

export const getHotel = async (req, res) => {
    try {
        const id = req.params.id
        const hotel = await Hotel.find({ _id: id })
        if (!hotel) {
            return res.status(404).json({ msg: "Such hotel no longer exists." })
        }
        res.status(200).json({ data: hotel })
    } catch (error) {
        res.status(500).json({ msg: error.message })
    }
};


// Used this to add data to the database for the development purpose only.
export const addHotel = async (req, res) => {
    try {
        const hotel = await Hotel.create(req.body)
        res.status(200).json({ success: true, data: hotel })
    } catch (error) {
        res.status(500).json({ msg: error.message })
    }
};

