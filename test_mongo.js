const mongoose = require('mongoose');

const tryConnect = async (pass) => {
    const uri = `mongodb+srv://shubhamj26022006_db_user:${pass}@cluster0.ezvxnpi.mongodb.net/hiremap?appName=Cluster0`;
    try {
        await mongoose.connect(uri);
        console.log('SUCCESS with: ' + pass);
        process.exit(0);
    } catch(e) {
        console.log('FAIL with: ' + pass + ' - ' + e.message);
    }
};

(async () => {
    await tryConnect('Shubham@123'); // raw
    await tryConnect('Shubham%2540123'); // double encoded 
    await tryConnect('Shubham123'); // maybe they forgot the @?
    console.log('Finished testing.');
    process.exit(1);
})();
