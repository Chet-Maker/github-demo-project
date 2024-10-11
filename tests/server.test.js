describe('Dummy Tests', () => {
    it('should always pass - test 1', () => {
        expect(true).toBe(true);
    });

    it('should always pass - test 2', () => {
        expect(1 + 1).toBe(2);
    });

    it('should always pass - test 3', () => {
        expect('hello').toMatch(/hello/);
    });

    it('should always pass - test 4', () => {
        expect([1, 2, 3]).toContain(2);
    });

    it('should always pass - test 5', () => {
        expect({ a: 1 }).toHaveProperty('a');
    });
});