// https://simonboisset.com/blog/create-esbuild-app/

const path = require('path')

const clientEnv = { 'process.env.NODE_ENV': `'dev'` };
for (const key in process.env) {  
  if (key.indexOf('CLIENT_') === 0) {    
    clientEnv[`process.env.${key}`] = `'${process.env[key]}'`;
  }
};

require("esbuild").build({
  entryPoints: ["application.js"],  
  bundle: true,
  outdir: path.join(process.cwd(), "app/assets/builds"),
  absWorkingDir: path.join(process.cwd(), "app/javascript"),
  watch: true,
  define: clientEnv  
}).catch(() => process.exit(1));