

import express from "express";

// import controllers
import { getAllDestinations, getDestination, addDestination} from "../controllers/destinationController.js";

const destinationRouter = express.Router();

// handles getting a list of many destinations either by search query or not
destinationRouter.get("/", getAllDestinations);

// handles getting a specific destination by id
destinationRouter.get("/:id", getDestination);

// add destination
destinationRouter.post("/", addDestination);


export default destinationRouter;
