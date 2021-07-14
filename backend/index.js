const express = require("express")
const app = express()

const connectdb = require("./config/db")

const port = 4000 || process.env.PORT

app.use(express.json())

connectdb();

app.listen(port, ()=> console.log(`Server is runnig at ${port}`))

var cors = require("cors")
app.use(cors({origin:true,credentials:true}))


require("./routes/main")(app);