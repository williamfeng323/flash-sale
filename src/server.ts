/* tslint:disable:max-line-length */
// https://git.xogrp.com/Registry-Ruby/Replatform/blob/dev/Registry.Libraries/Autolink/XO.Registry.Autolink/AutolinkAlgorithm.cs
/* tslint:enable:max-line-length */
import * as koa from 'koa';
import * as body from 'koa-bodyparser';
import * as koaRouter from 'koa-joi-router';
import * as koaError from 'koa-json-error';
import * as logger from 'koa-logger';

const qs = require('koa-qs');

const app = new koa();
app.use(logger());
app.use(koaError());
app.use(body({
  jsonLimit: '256kb',
}));

qs(app);

const checkHealth = koaRouter();
(checkHealth as any).get('/', (ctx: any) => {
  ctx.status = 200;
  ctx.body = 'application is up and running!';
});

// response
app.use(checkHealth.middleware())

app.listen(3000);
