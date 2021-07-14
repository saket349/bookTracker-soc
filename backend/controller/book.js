const Bookservice = require("../services/book")


exports.createBook = async(req, res) => {
    let data = req.body;
    let arg = { query: data };
    var userdata = await Bookservice.createBook(arg)
    if(userdata.done){
        return res.status(200).json(userdata)
    }else{
        return res.status(404).json(userdata)
    }
}

exports.getBook = async (req, res) => {  
    let query = {};
    let response = await Bookservice.getBook({
      query
    });
    if (response.success) {
      return res.status(200).json(response);
    } else {
      return res.status(400).json(response);
    }
};

exports.updateBook = async (req, res) => {
    let body = req.body;
    const id = req.query.id;  
    let setData = body;
  
    let argObj = {
      filterQuery: { _id: id },
      setData: setData
    };
  
    let response = await Bookservice.updateBook(argObj);

    if (response.success) {
      return res
        .status(200)
        .json({ status: true, message: "Book updated successfully" });
    } else {
      return res.status(400).json(response);
    }
};

exports.deleteBook = async(req, res) => {
    const id = req.query.id;
    
    let response = await Bookservice.deleteBook(id);

    if(response.success){
        return res.status(200).json(response)
    }else{
        return res.status(400).json(response)
    }
}