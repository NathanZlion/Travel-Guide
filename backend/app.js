
import mongoose from "mongoose";
import express from "express";
import dotenv from "dotenv";
import cors from "cors"
dotenv.config();

// all routers
import hotelRouter from "./routes/hotelRouter.js";
import destinationRouter from "./routes/destinationsRouter.js";
import restaurantRouter from "./routes/restaurantRouter.js";


const app = express();

// parse all data in json format
app.use(express.json());

app.use((req, res, next) => {
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader(
        "Access-Control-Allow-Headers",
        "Authorization, Origin, X-Requested-With, Content-Type, Accept");
    res.setHeader("Access-Control-Allow-Methods",
        "GET, POST, PATCH, DELETE, OPTIONS");
    next();
})


// use routers
app.use("/api/hotel", hotelRouter);
app.use("/api/destination", destinationRouter);
app.use("/api/restaurant", restaurantRouter);

mongoose.set('strictQuery', false);

async function connectToDb() {
    try {
        await mongoose.connect(process.env.MONGODBURL, { useNewUrlParser: true, useUnifiedTopology: true });
        console.log(`Connected to database successfully`);
    } catch (error) {
        console.log(`this is an error message`);
        console.log(error.message);
    }
}


async function startServer() {
    try {
        app.use(cors({
            origin: 'http://localhost:3000'
        }));
        app.listen(process.env.PORT, (error) => {
            if (error){
                console.log(error);4
            }
        });
        console.log((`Listening through port ${process.env.PORT}`));
    } catch (error) {
        console.log(error.message);
    }
}

connectToDb();
startServer();
