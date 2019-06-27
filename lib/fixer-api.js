const fixer = require('fixer-api');

const constants = require('../config/constants');

fixer.set({ accessKey: constants.FIXER_API_KEY })
// await fixer.set()
module.exports = fixer;
