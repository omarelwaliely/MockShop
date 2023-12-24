import mongoose, { Schema, Document, Model } from 'mongoose';

interface UserData {
    fullname: string;
    username: string;
    password: string;
    email: string;
    accounttype: string;
}

const dataSchema: Schema<UserData & Document> = new Schema({
    fullname: {
        required: true,
        type: String,
    },
    username: {
        required: true,
        type: String,
    },
    password: {
        required: true,
        type: String,
    },
    email: {
        required: true,
        type: String,
    },
    accounttype: {
        required: true,
        type: String,
    },
});

const UserModel: Model<UserData & Document> = mongoose.model('users', dataSchema);

export default UserModel;