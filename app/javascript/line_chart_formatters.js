const OUT_OF_RANGE_COLOR = '#ff0000'

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

function getChartDataPoint(chart, x) {
    const seriesData = chart.series[0].data
    const dataPoint = seriesData.find(point => point.x === x)
    return dataPoint
}

function setOutOfRangeTooltipContent(content, point) {
    let outOfRangeText = ''
    if (point.outOfRange === 'underrange')
        outOfRangeText = 'less'
    if (point.outOfRange === 'overrange')
        outOfRangeText = 'more'
    content[1] = content[1].replace('<br/>', ` or ${outOfRangeText}<br/>`)

    return content
}

export function metricsTooltipFormatter(tooltip) {
    const point = this.point
    const defaultContent = tooltip.defaultFormatter.call(this, tooltip)
    const recommendations = getMessagesForTooltip(this)
    const recommendationsCode = recommendations.map((r) => `<span>${r}</span><br>`)
    let content = defaultContent.concat(recommendationsCode)
    if (point.outOfRange) {
        content = setOutOfRangeTooltipContent(content, point)
    }
    return content
}

export function setOutOfRangeValues(event) {
    const labels = event.target.annotations[0].labels
    for (let i in labels) {
        const label = labels[i]
        const labelPoint = label.points[0]
        const dataPoint = getChartDataPoint(event.target, labelPoint.x)

        // if (!dataPoint) {
        //     continue;
        // }

        dataPoint.update({color: OUT_OF_RANGE_COLOR, outOfRange: label.options.text})
    }
    event.target.redraw()
}
