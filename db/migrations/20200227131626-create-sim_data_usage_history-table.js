'use strict';

module.exports = {
	up: (queryInterface, Sequelize) => {

		/**
		 * sim_status: String
		 * billing_unit
		 * upload_data
		 * download_data
		 * total_data
		 * billed
		 * period_start
		 * period_end
		 * commands
		 * data
		 * created_at
		 * updated_at
		 */

		return queryInterface.createTable('sim_data_usage_history', {
			id: {
				type: Sequelize.INTEGER,
				primaryKey: true,
				autoIncrement: true
			},
			unique_name: {
				type: Sequelize.STRING,
				allowNull: false,
			},
			iccid: {
				type: Sequelize.STRING,
				allowNull: false
			},
			sid: {
				type: Sequelize.STRING,
				allowNull: false,
			},
			sim_status: {
				type: Sequelize.STRING,
			},
			billing_unit: {
				type: Sequelize.INTEGER
			},
			upload_data: {
				type: Sequelize.INTEGER
			},
			download_data: {
				type: Sequelize.INTEGER
			},
			total_data: {
				type: Sequelize.INTEGER
			},
			billed: {
				type: Sequelize.INTEGER
			},
			period_start: {
				type: Sequelize.STRING
			},
			period_end: {
				type: Sequelize.STRING
			},
			commands: {
				type: Sequelize.TEXT
			},
			data: {
				type: Sequelize.TEXT
			},
			created_at: {
				type: 'TIMESTAMP',
				defaultValue: Sequelize.literal('CURRENT_TIMESTAMP'),
			},
			updated_at: {
				type: 'TIMESTAMP',
				defaultValue: Sequelize.literal('CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'),
			}
		})
	},

	down: (queryInterface, Sequelize) => {
		/*
		  Add reverting commands here.
		  Return a promise to correctly handle asynchronicity.
	
		  Example:
		  return queryInterface.dropTable('users');
		*/
	}
};
