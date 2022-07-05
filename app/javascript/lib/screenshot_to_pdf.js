import jsPDF from "jspdf";

const elementHeightCorrection = {
  top: e => e + 95,
  separator: e => 14,
  chart: e => e + 120,
}

export default class ScreenshotToPdf {

  static async convert(canvas) {
    const converter = new ScreenshotToPdf(canvas)
    const result = converter.result()
    return result
  }

  constructor(canvas) {
    this.canvas = canvas
  }

  async result() {
    const pageHeight = 480 * (1920 / 400)
    const pdf = new jsPDF({
      orientation: 'p',
      unit: 'mm',
      format: [400, 480]
    })

    const imgWidth = this.canvas.width
    const imgHeight = this.canvas.height
    const imgMargin = 100
    let heightLeft = imgHeight
    let position = 0
    let firstPage = true

    const breakpoints = this.getPageBreakpoints()
    let lastBreakpointId = -1

    while (heightLeft > imgMargin) {
      if (!firstPage) {
        pdf.addPage()
      }

      position = imgHeight - heightLeft
      let currentPageHeight = 0
      if (firstPage) {
        currentPageHeight += elementHeightCorrection.top(breakpoints[0].element.offsetTop)
      }

      for (let i = lastBreakpointId + 1; i < breakpoints.length; i++) {
        const breakpoint = breakpoints[i]
        const element = breakpoint.element
        const height = elementHeightCorrection[breakpoint.type](element.offsetHeight)

        if (currentPageHeight + height > pageHeight) {
          break;
        }

        currentPageHeight += height
        lastBreakpointId = i
      }

      const lastBreakpoint = breakpoints[lastBreakpointId]
      if (lastBreakpoint.type === 'separator') {
        currentPageHeight -= 30
        lastBreakpointId--
      }

      if (currentPageHeight === 0) {
        currentPageHeight = heightLeft
      }

      await this.addImageToPdf(pdf, position, imgWidth, currentPageHeight)

      heightLeft -= currentPageHeight
      firstPage = false
    }

    return pdf
  }

  async addImageToPdf(pdf, position, imgWidth, pageHeight) {
    const pdfImageWidthRatio = 1/2654
    const pdfImageWidthMultiplier = 1.24
    const pdfWidth = 400
    const pdfHeight = pdfWidth * pageHeight *  pdfImageWidthRatio * pdfImageWidthMultiplier
    const cropped = await this.cropImage(position, imgWidth, pageHeight)
    console.log(cropped)
    pdf.addImage(cropped, "PNG", 0, 0, pdfWidth, pdfHeight)
  }

  async cropImage(position, imgWidth, pageHeight) {
    const buffer = document.createElement('canvas')
    const context = buffer.getContext('2d')
    buffer.width = imgWidth
    buffer.height = pageHeight
    context.drawImage(this.canvas, 0, position, imgWidth, pageHeight, 0, 0, buffer.width, buffer.height)
    return buffer.toDataURL('image/png')
  }

  getPageBreakpoints() {
    let breakpointElements = []
    const separators = document.querySelectorAll('.export-page .export-content .vessel-line-separator')

    separators.forEach((separator) => {
      let lastBreakpointElement = separator

      breakpointElements.push({type: 'separator', element: separator})

      do {
        const breakpointElement = lastBreakpointElement.nextElementSibling
        if (!breakpointElement) {
          break;
        }

        if (breakpointElement.classList.contains('vessel-line-separator')) {
          break;
        }

        breakpointElements.push({type: 'chart', element: breakpointElement})
        lastBreakpointElement = breakpointElement
      } while (true)
    })

    return breakpointElements
  }
}

