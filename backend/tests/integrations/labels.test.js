const supertest = require('supertest');

const app = require('../../app');
const db = require('../../src/db/models');
const initDatabase = require('../../src/db/utils/initDatabase');

const request = supertest(app);

beforeAll(async (done) => {
  console.log('initializing test database...');
  await initDatabase({ logger: undefined, closeAfter: false });
  db.sequelize.authenticate();
  done();
}, 20000);

afterAll(() => {
  db.sequelize.close();
});

const originalLabels = [{
  id: 1,
  title: 'enhancement',
  description: 'New feature or request',
  color: '#000000',
  backgroundColor: '#a2eeef',
},
{
  id: 2,
  title: 'bug',
  description: 'Something isn\'t working',
  color: '#FFFFFF',
  backgroundColor: '#d73a4a',
},
{
  id: 3,
  title: 'documentation',
  description: 'Improvements or additions to documentation',
  color: '#FFFFFF',
  backgroundColor: '#0075ca',
}];

const newLabel = {
  title: 'BE',
  description: 'Backend',
  color: '#000000',
  backgroundColor: '#05932e',
};

const postedLables = [...originalLabels, { id: 4, ...newLabel }];

const changedLabel = {
  id: 4,
  title: 'BE-modified',
  description: 'Backend-modified',
  color: '#FFFFFF',
  backgroundColor: '#bde86d',
};

const changedLabels = [...originalLabels, { id: 4, ...changedLabel }];

const successResponse = {
  message: 'success',
};

describe('test labels API CRUD', () => {
  test('get labels', async () => {
    const response = await request.get('/api/labels');
    expect(response.status).toBe(200);
    expect(response.body).toEqual(originalLabels);
  });
  test('post labels', async () => {
    const response = await request.post('/api/labels').send(newLabel);
    expect(response.status).toBe(200);
    expect(response.body).toEqual(successResponse);
    const deletedResponse = await request.get('/api/labels');
    expect(deletedResponse.status).toBe(200);
    expect(deletedResponse.body).toEqual(postedLables);
  });
  test('put labels', async () => {
    const response = await request.put('/api/labels').send(changedLabel);
    expect(response.status).toBe(200);
    expect(response.body).toEqual(successResponse);
    const deletedResponse = await request.get('/api/labels');
    expect(deletedResponse.status).toBe(200);
    expect(deletedResponse.body).toEqual(changedLabels);
  });
  test('delete labels', async () => {
    const response = await request.delete('/api/labels').send({ id: 4 });
    expect(response.status).toBe(200);
    expect(response.body).toEqual(successResponse);
    const deletedResponse = await request.get('/api/labels');
    expect(deletedResponse.status).toBe(200);
    expect(deletedResponse.body).toEqual(originalLabels);
  });
});
