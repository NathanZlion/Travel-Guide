

// import mongoose from "mongoose";

import User from "../Models/userModel.js";

import dotenv from "dotenv";
dotenv.config();
import jwt from "jsonwebtoken"
import validator from "validator"

import bcrypt from 'bcryptjs';
// import { ObjectId } from "mongoose";
import { authorizationChecker } from "../middleware/auth.js"

// export default async (req,res)=>{
//     const {authorization}=req.headers;
//     if (!authorization){
//        return  "A"
//     }
//     const token=authorization.split(' ')[1];

//     /** 
//      * here is the error
//     */
//     const {_id}= jwt.verify(token,process.env.KEY);
//     const id =Types.ObjectId(_id)

//     const user =await User.findOne({_id:id})
//     return user ? user : "C"
// }

// export const getAllUsers = async (req, res, next) => {
//     let users;
//     try {
//         users = await User.find();
//     } catch (error) {
//         console.log(error);
//         return res.status(500).json({ message: error.message });
//     }

//     if (!users) {
//         return res.status(404).json({ message: "no users found!" });
//     }
//     return res.status(200).json({ users });
// }

// export const getProfile = async (req, res, next) => {
// }

// export const updateProfile = async (req, res, next) => {}


// authentication must be made here
// signup
export const signup = async (req, res) => {

    const { name, email, password } = req.body;
    try {
        if (!validator.isEmail(email)) {
            return res.status(400).json({ msg: "invalid email format" })
        }
        if (!validator.isStrongPassword(password)) {
            return res.status(400).json({ msg: "weak password" })
        }
        const user = await User.findOne({ email });
        if (user) {
            return res.status(400).json({ msg: "User account already exists, Login instead." })
        }
        const salt = await bcrypt.genSalt(10)
        const hashedPassword = await bcrypt.hash(password, salt)

        const newUser = await User.create({ name, password: hashedPassword, email })

        const token = jwt.sign({ _id: newUser._id }, process.env.KEY)
        res.status(201).json({ data: { token, detail: newUser } })
        // console.log( name, email, password)
        res.status(200).json({ name, email, password })
    } catch (error) {
        res.status(401).json({ msg: error.message });
    }
}


// login
export const login = async (req, res) => {
    const { email, password } = req.body;
    try {
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ msg: "User account dosnt exists" })
        }
        const passCheck = await bcrypt.compare(password, user.password)
        if (!passCheck) {
            return res.status(400).json({ msg: "incorrect password" })
        }
        const token = jwt.sign({ _id: user._id }, process.env.KEY)
        res.status(201).json({ data: { token, detail: user } })
    } catch (error) {
        res.json({ msg: error.message });
    }
}


export const updateUser = async (req, res) => {
    try {
        const auth = await authorizationChecker(req)
        if (auth === "A") {
            return res.status(401).json({ msg: "token reqired" })
        }
        else if (auth === "C") {
            return res.status(401).json({ msg: "not auth" })
        }
        const user = await User.findOneAndUpdate({ _id: auth.id, }, req.body, { new: true })
        if (!user) {
            return res.status(404).json({ msg: "No such user " })
        }
        res.status(200).json({ success: true, data: user })
    } catch (error) {
        res.status(500).json({ msg: error.message })
    }
}
