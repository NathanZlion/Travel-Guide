

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
        let destinations = Destination.find(query);

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



// export const getPkgComment = async (req, res) => {
//     const pkg_id = req.params.id
//     try {
//         const pkg = await Comment.find({ pkg: pkg_id });
//         if (!pkg) {
//             return res.status(404).json({ msg: "no such package exists sorry " });
//         }
//         return res.status(200).json({ data: pkg });
//     } catch (error) {
//         res.status(400).json({ msg: error.message });
//     }
// }
// export const getPkgHotel = async (req, res) => {
//     const pkg_id = req.params.id
//     try {
//         const selectedpkg = await Package.find({ _id: pkg_id });

//         const pkg = selectedpkg[0].location
//         console.log(pkg)
//         const hotel = await Hotel.find({ location: pkg });
//         if (!hotel) {
//             return res.status(404).json({ msg: "no such package exists sorry " });
//         }
//         return res.status(200).json({ data: hotel });
//     } catch (error) {
//         res.status(400).json({ msg: error.message });
//     }
// }


// export const addPackage = async (req, res) => {
//     try {
//         const auth = await authorizationChecker(req)
//         if (auth === "A") {
//             return res.status(401).json({ msg: "token reqired" })
//         }
//         else if (auth === "C") {
//             return res.status(401).json({ msg: "not auth" })
//         }
//         // authorize(res,auth,"admin")
//         const pkg = await Package.create(req.body)
//         res.status(200).json({ success: true, data: pkg })
//     } catch (error) {
//         res.status(500).json({ msg: error.message })
//     }
// }
// export const updatePackage = async (req, res) => {
//     try {
//         const auth = await authorizationChecker(req)
//         if (auth === "A") {
//             return res.status(401).json({ msg: "token reqired" })
//         }
//         else if (auth === "C") {
//             return res.status(401).json({ msg: "not auth" })
//         }
//         authorize(res, auth, "admin")
//         const pkg = await Package.findOneAndUpdate({ _id: req.params.id, }, req.body, { new: true })
//         if (!booking) {
//             return res.status(404).json({ msg: "No such package " })
//         }
//         res.status(200).json({ success: true, data: pkg })
//     } catch (error) {
//         res.status(500).json({ msg: error.message })
//     }
// }
// export const deletePackage = async (req, res) => {

//     try {
//         const auth = await authorizationChecker(req)
//         if (auth === "A") {
//             return res.status(401).json({ msg: "token reqired" })
//         }
//         else if (auth === "C") {
//             return res.status(401).json({ msg: "not auth" })
//         }
//         const pkg = await Package.findOneAndDelete({ _id: req.params.id })
//         return res.status(200).json({ data: pkg })

//     }
//     catch (error) {
//         res.status(500).json({ msg: error.message })
//     }
// }

// export const ratePackage = async (req, res) => {

//     try {
//         const auth = await authorizationChecker(req)

//         if (auth === "A") {
//             return res.status(401).json({ msg: "token reqired" })
//         }
//         else if (auth === "C") {
//             return res.status(401).json({ msg: "not auth" })
//         }
//         const pkg_id = req.params.id
//         const pkg_rate = await Package.findById(pkg_id).select("rating  totalRatings");
//         if (!pkg_rate) {
//             return res.status(404).json({ msg: "no such package exists sorry" })
//         }
//         const new_rating = (req.body.user_rate + (pkg_rate.totalRatings * pkg_rate.rating)) / (pkg_rate.totalRatings + 1)
//         const updated_one = { totalRatings: pkg_rate.totalRatings + 1, rating: new_rating }
//         const newpkg = await Package.findOneAndUpdate({ _id: pkg_id }, updated_one, { new: true })
//         res.status(200).json({ data: newpkg })
//     } catch (error) {
//         res.status(401).json({ msg: error.message });
//     }
// };
