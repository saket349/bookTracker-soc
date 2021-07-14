const mongoose  = require("mongoose")
const config = require("config")

const db = config.get("mongourl")

const connectdb = async() => {
    try {
        await mongoose.connect(db,{
            useNewUrlParser: true,
            useUnifiedTopology: true,
        });
        console.log("MongoDB is Connected........!!!")
    } catch (error) {
        console.error(error.message);
        process.exit(1);
    }
}

module.exports = connectdb;