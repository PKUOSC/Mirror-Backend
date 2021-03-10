/*
 * @file index.js
 * @author Zizheng Guo
 * @brief Monitor backend REST api server. It reads file system to get synchronization status.
 */

const fs = require('fs/promises');
const express = require('express');
const nocache = require('nocache');

const app = express();

// Log directory. must be same as what's in cron/mon.sh
const logdir = '/data/PKUMirror/log';

app.route('/stat').all(nocache()).get(async (req, res) => {
  // return res.json({'test': true});
  const stat = {};
  for(const name of await fs.readdir(`${logdir}/done`)) {
    const stats = await fs.stat(`${logdir}/done/${name}`);
    stat[name] = {
      'status': 'done',
      'timestamp': stats.mtimeMs,
    };
  }
  for(const name of await fs.readdir(`${logdir}/error`)) {
    const stats = await fs.stat(`${logdir}/error/${name}`);
    stat[name] = {
      'status': 'error',
      'timestamp': stats.mtimeMs,
    };
  }
  for(const name of await fs.readdir(`${logdir}/running`)) {
    const stats = await fs.stat(`${logdir}/running/${name}`);
    stat[name] = {
      'status': 'running',
      'timestamp': stats.ctimeMs,
    };
  }
  res.json(stat);
});

app.listen(process.env.PORT || 3000, () => {
  console.log(`Monitor listening on port ${process.env.PORT || 3000}`);
});
