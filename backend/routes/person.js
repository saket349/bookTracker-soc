const express = require("express")

const router = express.Router()

const personController = require("../controller/person")

router.post("/post", personController.createPerson)
router.get("/list",personController.getUser)
router.put("/upd",personController.updatePerson)
router.delete("/del",personController.deletePerson)

module.exports = router;