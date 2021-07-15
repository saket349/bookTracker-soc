const Personservice = require("../services/person")
const Bookservice = require("../services/book")


exports.createPerson = async(req, res) => {
    let data = req.body;
    let arg = { query: data };
    var userdata = await Personservice.createPerson(arg)
    if(userdata.done){
        return res.status(200).json(userdata)
    }else{
        return res.status(404).json(userdata)
    }
}

exports.getUser = async (req, res) => {  
    let query = {};
    let response = await Personservice.getPerson({
      query
    });
    if (response.success) {
      return res.status(200).json(response);
    } else {
      return res.status(400).json(response);
    }
};

exports.updatePerson = async (req, res) => {
    let body = req.body;
    const id = req.query.id;  
    let setData = body;
  
    let argObj = {
      filterQuery: { _id: id },
      setData: setData
    };
  
    let response = await Personservice.updatePerson(argObj);

    if (response.success) {
      return res
        .status(200)
        .json({ status: true, message: "Person data updated successfully" });
    } else {
      return res.status(400).json(response);
    }
};

exports.deletePerson = async(req, res) => {
    const id = req.query.id;
    
    let response = await Personservice.deletePerson(id);

    if(response.success){
        return res.status(200).json(response)
    }else{
        return res.status(400).json(response)
    }
}

exports.mybook = async(req, res) => {
    const id = req.query.id;
    let query = {
      ownerID : id
    };    
    let response = await Bookservice.getBook({
      query
    });

    if(response.success){
        return res.status(200).json(response)
    }else{
        return res.status(400).json(response)
    }
}