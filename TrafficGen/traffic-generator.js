const axios = require('axios');

const url = 'http://40.80.157.109/productpage';
const requests = 1000;

for(let i = 0; i < requests; i++){
    axios.get(url)
        .then(result => {
            console.log(`${result.headers.date} ${result.status} - ${result.statusText} : ${result.headers.server}`);
        })
        .catch(error => {
            console.error(`${error.stack}`);
        });
}