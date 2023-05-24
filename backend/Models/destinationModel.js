

import mongoose from 'mongoose';


const destinationSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        unique: true
    },
    location: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    image: {
        type: String,
        required: false,
    },
    rating: {
        type: Number,
        default: 0,
    },
    things_to_do: {
        type: [String],
        required: true,
    },
    map: {
        type: String,
    }
}, {
    timestamps: true
});

const Destination = mongoose.model('Destination', destinationSchema);

export default Destination;