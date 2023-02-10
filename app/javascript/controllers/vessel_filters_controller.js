import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="vessel-filters"
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

  submit() {
    if (this.lock_submit) return;

    this.form.submit()
  }

  reset_parameters(set_checked) {
    let checked = (typeof set_checked !== "undefined") ? set_checked : false
    this.lock_submit = true

    for(let key in Object.keys(this.parameter_inputs)) {
      const input = this.parameter_inputs[key]
      input.checked = checked
    }

    this.lock_submit = false
  }

  change_system() {
    this.reset_parameters()
    this.submit()
  }

  select_all_parameters() {
    const target_state = !this.are_all_selected()
    this.reset_parameters(target_state)
    this.submit()
  }
}
