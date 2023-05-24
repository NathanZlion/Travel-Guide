

import Hotel from "../Models/hotelModel.js";



export const getHotels = async (req, res) => {
    try {
        let query = {};
        if (req.query.location) {
            query.location = req.query.location;
        }

        if (req.query.query) {
            query.name = { $regex: query.name, $options: 'i' };
        }

        if (req.query.location) query.location = { $regex: query.location, $options: 'i' };

        // find related hotels based on the query, don't have to have the same name but related
        let Hotels = await Hotel.find(query);

        if (!Hotels) return res.status(404).json({ msg: "No such hotel found!", data: [] });


        return res.status(200).json({ data: Hotels });

    } catch (error) {
        res.status(400).json({ msg: `${error.message} this is here` });
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


export const addHotel = async (req, res) => {
    try {
        const hotel = await Hotel.create(req.body)
        res.status(200).json({ success: true, data: hotel })
    } catch (error) {
        res.status(500).json({ msg: error.message })
    }
};



// export const getHotelRoom = async (req, res) => {
//     try {
//         const id = req.params.id
//         let rooms;
//         if (!req.query.taken) {
//             rooms = await Room.find({ hotel: id })
//         }
//         else {
//             rooms = await Room.find({ hotel: id, taken: false })
//         }
//         if (!rooms) {
//             return res.status(404).json({ msg: "No Hotel " })
//         }
//         res.status(200).json({ data: rooms })
//     } catch (error) {
//         res.status(500).json({ msg: error.message })
//     }
// }

// export const updateHotel = async (req, res) => {
//     try {
//         const auth = await authorizationChecker(req)
//         if (auth === "A") {
//             return res.status(401).json({ msg: "token reqired" })
//         }
//         else if (auth === "C") {
//             return res.status(401).json({ msg: "not auth" })
//         }
//         authorize(res, auth, "admin")
//         const hotel = await Hotel.findOneAndUpdate({ _id: req.params.id, }, req.body, { new: true })
//         if (!hotel) {
//             return res.status(404).json({ msg: "No Hotel " })
//         }
//         res.status(200).json({ success: true, data: hotel })
//     } catch (error) {
//         res.status(500).json({ msg: error.message })
//     }

// };
// export const deleteHotel = async (req, res) => {
//     try {
//         const auth = await authorizationChecker(req)


//         if (auth === "A") {
//             return res.status(401).json({ msg: "token reqired" })
//         }
//         else if (auth === "C") {
//             return res.status(401).json({ msg: "not auth" })
//         }
//         authorize(res, auth, "admin")
//         const hotel = await Hotel.findOneAndDelete({ _id: req.params.id })
//         res.status(200).json({ data: hotel })
//     }
//     catch (error) {
//         res.status(500).json({ msg: error.message })
//     }
// };
