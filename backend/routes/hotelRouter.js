
import express from "express";


import {getHotels, getHotel} from "../controllers/hotelController.js";

const hotelRouter  = express.Router();


hotelRouter.get("/", getHotels);
hotelRouter.get("/:id", getHotel);

export default hotelRouter;
