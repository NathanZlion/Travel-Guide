
import express from "express";


import {getHotels, getHotel, addHotel} from "../controllers/hotelController.js";

const hotelRouter  = express.Router();


hotelRouter.get("/", getHotels);
hotelRouter.get("/:id", getHotel);
hotelRouter.post("/", addHotel);

export default hotelRouter;
