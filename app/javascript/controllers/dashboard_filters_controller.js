import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.form = this.element.querySelector('form')
    this.parameter_inputs = this.element.querySelectorAll('input[name="parameter_ids[]"]')
  }

  select_all_parameters() {
    for(let key in Object.keys(this.parameter_inputs)) {
      const input = this.parameter_inputs[key]
      input.checked = true
    }
  }
}
