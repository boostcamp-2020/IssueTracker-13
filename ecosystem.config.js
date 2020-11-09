module.exports = {
  apps : [
    {
      name: 'issuetracker',
      script: 'npm start',
      env: {
        NODE_ENV: 'production',
        PORT: 80,
      },
    },
    {
      name: 'issuetracker-dev',
      script: 'npm start',
      watch: true,
      env: {
        NODE_ENV: 'development'
      }
    },
  ],
};