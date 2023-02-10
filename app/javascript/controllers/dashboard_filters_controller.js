import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.form = this.element.querySelector('form')
    this.parameter_inputs = this.element.querySelectorAll('input[name="parameter_ids[]"]')
    this.button = this.element.querySelector('.select-all')
    this.button.text = this.button_text()
  }

  button_text() {
    return this.are_all_selected() ? "Deselect All" : "Select All"
  }

  are_all_selected() {
    return this.element.querySelector('input[name="parameter_ids[]"]:not(.ignore-select):not(:checked)') === null
  }

  select_all_parameters() {
    const target_state = !this.are_all_selected()

    for (let key in Object.keys(this.parameter_inputs)) {
      const input = this.parameter_inputs[key]
      input.checked = target_state
    }
  }
}
