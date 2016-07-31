/* eslint-env mocha */
/* eslint-disable no-unused-expressions */

import fs from 'fs';
import {expect} from 'chai';
import csha1 from '../../src/data/sha1';

describe('data/sha1', () => {
  it('computes SHA-1', () => {
    const data = new Uint8Array(fs.readFileSync('./test/roms/nestest/nestest.nes'));
    expect(csha1(data)).to.be.equal('5b608f023b41399c34dfc6c847d8af084e0f7aeb');
  });
});
