import { Controller } from "@hotwired/stimulus"
import Highcharts from "highcharts"
import html2canvas from 'html2canvas'
import ScreenshotToPdf from "../lib/screenshot_to_pdf";

// Connects to data-controller="export-page"
export default class extends Controller {
  connect() {
    Highcharts.setOptions({
      plotOptions: {
        series: {
          animation: false
        }
      }
    })

    if (document.readyState === 'complete') {
      return this.run()
    }

    document.addEventListener('readystatechange', () => {
      if (document.readyState !== 'complete') {
        return
      }

      return this.run()
    })
  }

  isRendered() {
    if (!Highcharts.chartCount) {
      return false
    }

    for (let i in Highcharts.charts) {
      const chart = Highcharts.charts[i]
      const isRendered = chart.hasRendered

      if (!isRendered) {
        return false
      }
    }

    return true
  }

  async run() {
    if (!this.isRendered()) {
      return setTimeout(this.run.bind(this), 100)
    }

    this.getOutputPDF()
        .then(() => setTimeout(() => window.close(), 1000))
        .catch((e) => console.error(e))
        .catch(() => window.location.reload())
  }

  async takeScreenshot() {
    const element = document.querySelector('.export-page .export-content')
    const canvas = await html2canvas(element)

    return canvas
  }

  async getOutputPDF() {
    const canvas = await this.takeScreenshot()
    const pdf = await ScreenshotToPdf.convert(canvas)

    pdf.save('result.pdf')
  }
}
