const testResults = require('./test-results.json');

const passedTests = testResults.numPassedTests;
const failedTests = testResults.numFailedTests;
const skippedTests = testResults.numPendingTests;
const runtimeError = testResults.numRuntimeErrorTestSuites > 0;

function testSummary() {
  if (runtimeError) {
    return `runtime error, tests could not be executed`;
  }
  return `${passedTests} passed, ${failedTests} failed, ${skippedTests} skipped`
  // return `${passedTests} 👍 | ${failedTests} 👎 | ${skippedTests} 😴`
}

function trafficLight() {
  if (testResults.success) {
    return '🟢'
  }

  if (runtimeError) {
    return '🟡'
  }

  return '🔴'
}

console.log(`test(${trafficLight()}): ${testSummary()}`);