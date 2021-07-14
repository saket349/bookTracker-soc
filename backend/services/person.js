const Person = require("../models/person")

exports.createPerson = async (arg = {}) => {
    const { query = {} } = arg;
    try {
        var user = await Person.create(query);
        return { user, done: true, message: "person data submitted" }
    } catch (error) {
        return { error, done: false, message: "error in submitting data" }
    }
}

exports.getPerson = async (argObj = {}) => {
    const {
        query = {},
    } = argObj;
    try {
        var user = await Person.find(query)
        if (user) {
            return {
                count: await Person.countDocuments(query),
                user,
                success: true,
                message: "Persons found successfully.",
            };
        } else {
            return { user, success: false, message: "No Person found." };
        }
    } catch (error) {
        return {
            error,
            success: false,
            message: "Error while finding Person.",
        };
    }
};

exports.updatePerson = async (argObj = {}) => {
    const {
        filterQuery = {},
        setData = {},
    } = argObj;
    try {
        var userData = await Person.findOneAndUpdate(
            filterQuery,
            { $set: setData },
        )
        if (userData) {
            return {
                userData,
                success: true,
                message: "PersonData updated successfully.",
            };
        } else {
            return {
                userData,
                success: false,
                message: "PersonData not updated.",
            };
        }
    } catch (error) {
        return {
            error,
            success: false,
            message: "Error while finding PersonData.",
        };
    }
};

exports.deletePerson = async (id) => {
    try {
        var personData = await Person.findByIdAndDelete(id)
        if(personData){
            return {
                success : true,
                message : "PersonData deleted successfully"
            }
        }else{
            return{
                success : false,
                message : "PersonData not deleted"
            }
        }
    } catch (error) {
        return{
            success : false,
            message: "Error while deleting PersonData"
        }
    }
} 