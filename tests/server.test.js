const request = require('supertest');
const express = require('express');

const app = express();
const path = require('path');

app.use(express.static(path.join(__dirname, 'docs')));
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'docs', 'index.html'));
});

describe('GET /', () => {
    it('should return 200 OK', async () => {
        const response = await request(app).get('/');
        expect(response.statusCode).toBe(200);
    });

    it('should contain the correct title', async () => {
        const response = await request(app).get('/');
        expect(response.text).toContain('Welcome to GitHub Demo Project');
    });
});