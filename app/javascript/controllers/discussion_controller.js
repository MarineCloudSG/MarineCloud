import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="discussion"
export default class extends Controller {
  connect() {
  }

  show(e) {
    e.preventDefault()
    this.element.classList.remove('discussion-hidden')
  }

  hide(e) {
    e.preventDefault()
    this.element.classList.add('discussion-hidden')
  }
}
