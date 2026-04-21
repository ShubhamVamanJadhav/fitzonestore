const { MongoClient } = require('mongodb');

async function debugConnection() {
    const uri = "mongodb+srv://shubhamj26022006_db_user:Shubham%40123@cluster0.ezvxnpi.mongodb.net/hiremap?appName=Cluster0";
    console.log("Attempting direct MongoClient connection...");
    const client = new MongoClient(uri);

    try {
        await client.connect();
        console.log("DIRECT SUCCESS!");
        await client.db("admin").command({ ping: 1 });
        console.log("Ping successful!");
    } catch (e) {
        console.error("DIRECT FAILURE:", e.message);
        if (e.message.includes('authentication failed')) {
            console.log("Confirmed: Wrong credentials in URI.");
        }
    } finally {
        await client.close();
        process.exit();
    }
}

debugConnection();
