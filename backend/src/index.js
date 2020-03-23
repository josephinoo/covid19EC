const app= require('./app');
async function main () {
   await app.listen(4000);
    console.log('server on port :4000');
}
main();