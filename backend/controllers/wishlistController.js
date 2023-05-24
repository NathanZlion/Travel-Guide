
import mongoose from "mongoose";

import Package from "../Models/packageModel.js";
import { authorizationChecker } from "../middleware/auth.js";
import wishList from "../Models/wishListModel.js";
import { ObjectId } from "mongoose";

export const getWishlist = async (req, res) => {
    try {
        const auth = await authorizationChecker(req)

        if (auth === "A") {
            return res.status(401).json({
                msg
                    : "token reqired"
            })
        }
        else if (auth === "C") {
            return res.status(401).json({ msg: "not auth" })
        }
        const indPackage = await wishList.find({ user: auth._id })
        res.status(200).json({ success: true, data: indPackage })

    } catch (error) {
        res.status(400).json({ msg: error.message })
    }
}
export const deleteWishlist = async (req, res) => {
    const pkg_id = req.params.id
    try {
        const auth = await authorizationChecker(req)


        if (auth === "A") {
            return res.status(401).json({ msg: "token reqired" })
        }
        else if (auth === "C") {
            return res.status(401).json({ msg: "not auth" })
        }
        await wishList.findOneAndDelete({ _id: pkg_id })
        res.status(200).send()

    } catch (error) {
        res.status(400).json({ msg: error.message })
    }
}
export const createWishlist = async (req, res) => {
    try {
        const auth = await authorizationChecker(req)
        if (auth === "A") {
            return res.status(401).json({ msg: "token reqired" })
        }
        else if (auth === "C") {
            return res.status(401).json({ msg: "not auth" })
        }
        const indPackage = await wishList.create(req.body)
        res.status(200).json({ success: true, data: indPackage })

    } catch (error) {
        res.status(400).json({ msg: error.message })
    }
}
