/* eslint-disable no-undef */
const supertest = require('supertest');

const app = require('../../app');
const db = require('../../src/db/models');
const initDatabase = require('../../src/db/utils/initDatabase');

const request = supertest(app);

beforeAll(async () => {
  console.log('initializing test database...');
  await initDatabase({ logger: undefined, closeAfter: false });
  db.sequelize.authenticate();
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

  describe('when sending GET request to /api/labels', () => {
    let response, status, body;

    beforeAll(async () => {
      response = await request.get('/api/labels');
      ({ status, body } = response);
    });

    it('responds with status code 200', () => {
      expect(status).toBe(200);
    });

    it('responds with a body matching original labels', () => {
      expect(body).toEqual(originalLabels);
    });
  });

  describe('when sending POST request to /api/labels', () => {

    describe('on initial POST request', () => {
      let response, status, body;

      beforeAll(async () => {
        response = await request.post('/api/labels').send(newLabel);
        ({ status, body } = response);
      });

      it('responds with status code 200', () => {
        expect(status).toBe(200);
      });

      it('responds with a success message', () => {
        expect(body).toEqual(successResponse);
      });
    });

    describe('on following GET request', () => {
      let response, status, body;

      beforeAll(async () => {
        response = await request.get('/api/labels');
        ({ status, body } = response);
      });

      it('response with status code 200', () => {
        expect(status).toBe(200);
      });

      it('responds with a body with the posted label added', () => {
        expect(body).toEqual(postedLables);
      });
    });
  });

  describe('when sending PUT request to /api/labels', () => {

    describe('on initial PUT request', () => {
      let response, status, body;

      beforeAll(async () => {
        response = await request.put('/api/labels').send(changedLabel);
        ({ status, body } = response);
      });

      it('responds with status code 200', () => {
        expect(status).toBe(200);
      });

      it('responds with a success message', () => {
        expect(body).toEqual(successResponse);
      });
    });

    describe('on following GET request', () => {
      let response, status, body;

      beforeAll(async () => {
        response = await request.get('/api/labels');
        ({ status, body } = response);
      });

      it('response with status code 200', () => {
        expect(status).toBe(200);
      });

      it('responds with a body with the posted label added', () => {
        expect(body).toEqual(changedLabels);
      });
    });
  });

  describe('when sending DELETE request to /api/labels', () => {

    describe('on initial DELETE request', () => {
      let response, status, body;

      beforeAll(async () => {
        response = await request.delete('/api/labels').send({ id: 4 });
        ({ status, body } = response);
      });

      it('responds with status code 200', () => {
        expect(status).toBe(200);
      });

      it('responds with a success message', () => {
        expect(body).toEqual(successResponse);
      });
    });

    describe('on following GET request', () => {
      let response, status, body;

      beforeAll(async () => {
        response = await request.get('/api/labels');
        ({ status, body } = response);
      });

      it('response with status code 200', () => {
        expect(status).toBe(200);
      });

      it('responds with a body with the label deleted', () => {
        expect(body).toEqual(originalLabels);
      });
    });
  });
});
