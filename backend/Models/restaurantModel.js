
import { Schema as _Schema, model } from 'mongoose';
const Schema = _Schema;

const restaurantSchema = new Schema({
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
    image: [{
        type: String,
        required: false,
    }],
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



const Restaurant = model('Restaurant', restaurantSchema);
export default Restaurant;