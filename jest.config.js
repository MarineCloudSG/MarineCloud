/*
 * For a detailed explanation regarding each configuration property, visit:
 * https://jestjs.io/docs/configuration
 */

module.exports = {
  // Test setup file
  setupFilesAfterEnv: ["<rootDir>/app/javascript/setupTests.js"],

  // Test environment
  testEnvironment: "jsdom",

  // To collect coverage from untested files
  collectCoverageFrom: ["<rootDir>/app/javascript/**/*.jsx"],

  // Automatically clear mock calls and instances between every test
  clearMocks: true,

  // Indicates whether the coverage information should be collected while executing the test
  collectCoverage: true,

  // The directory where Jest should output its coverage files
  coverageDirectory: "coverage",

  // The glob patterns Jest uses to detect test files
  testMatch: ["**/__tests__/**/*.[jt]s?(x)", "**/?(*.)+(spec|test).[tj]s?(x)"],

  // An array of regexp pattern strings that are matched against all test paths, matched tests are skipped
  testPathIgnorePatterns: ["/node_modules/", "/config/webpack/"],
};
