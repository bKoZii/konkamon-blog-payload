module.exports = {
  root: true,
  extends: ['plugin:@next/next/recommended', '@payloadcms'],
  ignorePatterns: ['**/payload-types.ts'],
  plugins: ['prettier', 'quotes'],
  rules: {
     "quotes/quotes": [2, "single", { avoidEscape: true }],
  },
}
