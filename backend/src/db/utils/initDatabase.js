const path = require('path');
const { Umzug, SequelizeStorage, memoryStorage } = require('umzug');

const db = require('../models');

const sequelize = db.sequelize;

const disableLogger = (sequelize) => {
  sequelize.options.logging = false;
};

const getMigrations = (logger) => new Umzug({
  migrations: {
    glob: path.resolve(__dirname, '../migrations/*.js'),
    resolve: ({ name, path, context }) => {
      const migration = require(path);
      return {
        name,
        up: () => migration.up(...context),
        down: () => migration.down(...context),
      };
    },
  },
  context: [sequelize.getQueryInterface(), db.Sequelize],
  storage: new SequelizeStorage({ sequelize }),
  logger,
});

const getSeeders = (logger) => new Umzug({
  migrations: {
    glob: path.resolve(__dirname, '../seeders/*.js'),
    resolve: ({ name, path, context }) => {
      const migration = require(path);
      return {
        name,
        up: () => migration.up(...context),
        down: () => migration.down(...context),
      };
    },
  },
  context: [sequelize.getQueryInterface(), db.Sequelize],
  storage: memoryStorage(),
  logger,
});

const initDatabase = async ({ logger, closeAfter } = { logger: console, closeAfter: true }) => {
  disableLogger(sequelize);
  const migrations = getMigrations(logger);
  const seeders = getSeeders(logger);
  await migrations.down({ to: 0 });
  await migrations.up();
  await seeders.up();
  if (closeAfter) {
    sequelize.close();
  }
};

module.exports = initDatabase;
