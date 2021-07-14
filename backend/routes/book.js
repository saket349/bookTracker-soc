const express = require("express")

const router = express.Router()

const bookController = require("../controller/book")

router.post("/post", bookController.createBook)
router.get("/list",bookController.getBook)
router.put("/upd",bookController.updateBook)
router.delete("/del",bookController.deleteBook)

module.exports = router;