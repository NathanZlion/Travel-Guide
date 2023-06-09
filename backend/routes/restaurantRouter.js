
import express from "express";

// import controllers
import { getRestaurants, getRestaurant, addRestaurant} from "../controllers/restaurantController.js";

const restaurantRouter = express.Router();

// handles getting a list of many destinations either by search query or not
restaurantRouter.get("/", getRestaurants);

// handles getting a specific restaurant by id
restaurantRouter.get("/:id", getRestaurant);

// handles adding a restaurant to the database
restaurantRouter.post("/", addRestaurant);




export default restaurantRouter;
