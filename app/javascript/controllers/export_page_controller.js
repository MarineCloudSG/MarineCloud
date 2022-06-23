import { Controller } from "@hotwired/stimulus"
import Highcharts from "highcharts"
import html2canvas from 'html2canvas'
import jsPDF from 'jspdf'

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
        .catch(() => window.location.reload())
  }

  async takeScreenshot() {
    const element = document.querySelector('.export-page .export-content')
    const canvas = await html2canvas(element)

    return canvas
  }

  async getOutputPDF() {
    const pageHeight = 480
    const canvas = await this.takeScreenshot()
    const image = canvas.toDataURL('image/png')
    const pdf = new jsPDF({
      orientation: 'p',
      unit: 'mm',
      format: [400, 480]
    })

    const imgWidth = 400
    const imgHeight = ((canvas.height * imgWidth) / 2454)*1.24;
    let heightLeft = imgHeight
    let position = 0
    let firstPage = true

    while (heightLeft >= 0) {
      if (!firstPage) {
        pdf.addPage()
      }

      position = heightLeft - imgHeight
      pdf.addImage(image, "PNG", 0, position, imgWidth, imgHeight)

      heightLeft -= pageHeight
      firstPage = false
    }

    pdf.save('result.pdf')
  }
}
