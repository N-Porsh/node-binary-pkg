const fs = require('fs');
const path = require('path');

const getConfig = (fileName) => {
	let filePath = path.join(path.dirname(process.execPath), 'external_config', fileName);
	if (!fs.existsSync(filePath)) {
		filePath = path.join(__dirname, '../config', fileName);
	}

	const config = fs.readFileSync(filePath);
	return JSON.parse(config);
}

module.exports = getConfig;