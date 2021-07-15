const mongoose = require("mongoose");
const schema = mongoose.Schema;

const personSchema = new schema(
    {
        name: {
            type: String,
            required: true,
            trim: true
        },

        uid: {
            type: String,
            // required: true,
            trim: true
        },

        year: {
            type: String,
            required: true,
            trim: true
        },

        hostel: {
            type: String,
            required: true,
            trim: true
        },

        room: {
            type: String,
            required: true,
            trim: true
        },

        dept: {
            type: String,
            required: true,
            trim: true
        },


        // 0 : male
        // 1 : female
        // 2 : other

        gender: {
            type: Number,
            trim: true,
            required: true
        },

    },
    {
        timestamps: true,
    }
);

module.exports = Person = mongoose.model("Person", personSchema);
