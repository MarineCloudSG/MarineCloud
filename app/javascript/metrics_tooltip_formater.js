function getChartIdFromChartObject(chart) {
    const chartEl = chart.container.parentElement
    const chartId = chartEl.id
    return chartId
}

function getRulesForChartId(chartId) {
    return recommendationRules[chartId]
}

function getRulesForChart(chart) {
    const chartId = getChartIdFromChartObject(chart)
    const rules = getRulesForChartId(chartId)
    return rules
}

function filterRulesFulfilledForValue(rules, value) {
    return rules.filter((rule) => (rule.min === null || rule.min < value) && (rule.max === null || rule.max > value))
}

function getRulesFulfilledForChart(chart, value) {
    const rules = getRulesForChart(chart)
    const fulfilled = filterRulesFulfilledForValue(rules, value)
    return fulfilled
}

function getMessagesForTooltip(tooltip) {
    const rules = getRulesFulfilledForChart(tooltip.series.chart, tooltip.y)
    const messages = rules.map((r) => r.message)
    return messages
}

function metricsTooltipFormatter (tooltip) {
    const defaultContent = tooltip.defaultFormatter.call(this, tooltip)
    const recommendations = getMessagesForTooltip(this)
    const recommendationsCode = recommendations.map((r) => `<span>${r}</span><br>`)
    const content = defaultContent.concat(recommendationsCode)
    return content
}

export default metricsTooltipFormatter
