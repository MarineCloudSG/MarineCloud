import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "link" ]

  connect() {
    this.linkTarget.classList.add('bg-gray-50', 'text-orange-600', 'hover:bg-white')
  }
}
