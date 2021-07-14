module.exports = (app) =>{
    app.use("/person", require("./person"));
    app.use("/book", require("./book"))
}