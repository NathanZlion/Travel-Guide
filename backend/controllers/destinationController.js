

import Destination from "../Models/destinationModel.js";


export const getAllDestinations = async (req, res) => {
    try {
        let query = {};

        if (req.query.search) {
            query.name = req.query.search;
        }
        if (req.query.location) {
            query.location = { $regex: req.query.location, $options: 'i' };
        }

        // find related destinations based on the query, don't have to have the same name but related
        let destinations = await Destination.find(query);

        if (!destinations) {
            return res.status(404).json({ msg: "no packages for today!", data: [] });
        }

        return res.status(200).json({ data: destinations });

    } catch (error) {
        res.status(400).json({ msg: error.message });
    }
}


export const getDestination = async (req, res) => {

    const destination_id = req.params.id
    try {
        const dest = await Package.findById(destination_id);
        if (!dest) {
            return res.status(404).json({ msg: "no such destination exists sorry", data: null });
        }
        return res.status(200).json({ data: dest });
    } catch (error) {
        res.status(400).json({ msg: error.message });
    }
}

export const addDestination = async (req, res) => {
    try {
        const destination = await Destination.create(req.body)
        res.status(200).json({ success: true, data: destination })
    } catch (error) {
        res.status(500).json({ msg: error.message })
    }
};
