module.exports = {
  apps : [
      {
      name: "issuetracker",
      script: "npm start",
      env: {
        NODE_ENV: "development",
      },
      env_production: {
        NODE_ENV: "production",
      },
    },
  ],
};