import mongoose, { Schema, Document, Model } from 'mongoose';

interface ProductData {
    vendorusername: string;
    productname: string;
    description: string;
    price: number;
}

const dataSchema: Schema<ProductData & Document> = new Schema({
    vendorusername: {
        required: true,
        type: String,
    },
    productname: {
        required: true,
        type: String,
    },
    description: {
        required: true,
        type: String,
    },
    price: {
        required: true,
        type: Number,
    },
});

const ProductModel: Model<ProductData & Document> = mongoose.model('products', dataSchema);

export default ProductModel;