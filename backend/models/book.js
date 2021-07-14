const mongoose = require("mongoose");
const schema = mongoose.Schema;

const bookSchema = new schema(
    {
        name: {
            type: String,
            required: true,
            trim: true
        },

        author: {
            type: String,
            required: true,
            trim: true
        },

        edition: {
            type: String,
            required: true,
            trim: true
        },

        isActive : {
            type: Boolean,
        },

    },
    {
        timestamps: true,
    }
);

module.exports = Person = mongoose.model("Book", bookSchema);
