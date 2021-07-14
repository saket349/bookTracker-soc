const Person = require("../models/book")

exports.createBook = async (arg = {}) => {
    const { query = {} } = arg;
    try {
        var user = await Person.create(query);
        return { user, done: true, message: "book data submitted" }
    } catch (error) {
        return { error, done: false, message: "error in submitting data" }
    }
}

exports.getBook = async (argObj = {}) => {
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
                message: "book/books found successfully.",
            };
        } else {
            return { user, success: false, message: "No book found." };
        }
    } catch (error) {
        return {
            error,
            success: false,
            message: "Error while finding Book.",
        };
    }
};

exports.updateBook = async (argObj = {}) => {
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
                message: "Book updated successfully.",
            };
        } else {
            return {
                userData,
                success: false,
                message: "Book not updated.",
            };
        }
    } catch (error) {
        return {
            error,
            success: false,
            message: "Error while finding Book.",
        };
    }
};

exports.deleteBook = async (id) => {
    try {
        var personData = await Person.findByIdAndDelete(id)
        if(personData){
            return {
                success : true,
                message : "book deleted successfully"
            }
        }else{
            return{
                success : false,
                message : "book not deleted"
            }
        }
    } catch (error) {
        return{
            success : false,
            message: "Error while deleting book"
        }
    }
} 