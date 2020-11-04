const db = require('../models');
const { Umzug, SequelizeStorage, memoryStorage } = require('umzug');
const sequelize = db.sequelize;

const disableLogger = (sequelize) => {
  sequelize.options.logging = false;
};

const migrations = new Umzug({
  migrations: {
    glob: 'src/db/migrations/*.js',
    resolve: ({ name, path, context }) => {
      const migration = require(path);
      return {
        name,
        up: async () => migration.up(...context),
        down: async () => migration.down(...context),
      };
    },
  },
  context: [sequelize.getQueryInterface(), db.Sequelize],
  storage: new SequelizeStorage({ sequelize }),
  logger: console,
});

const seeders = new Umzug({
  migrations: {
    glob: 'src/db/seeders/*.js',
    resolve: ({ name, path, context }) => {
      const migration = require(path);
      return {
        name,
        up: async () => migration.up(...context),
        down: async () => migration.down(...context),
      };
    },
  },
  context: [sequelize.getQueryInterface(), db.Sequelize],
  storage: memoryStorage(),
  logger: console,
});

(async () => {
  disableLogger(sequelize);
  await migrations.down({ to: 0 });
  await migrations.up();
  await seeders.up();
  sequelize.close();
})();
