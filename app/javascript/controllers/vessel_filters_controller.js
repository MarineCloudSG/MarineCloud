import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="vessel-filters"
export default class extends Controller {
  connect() {
    this.form = this.element.querySelector('form')
    this.parameter_inputs = this.element.querySelectorAll('input[name="parameter_ids[]"]')
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
    this.reset_parameters(true)
    this.submit()
  }
}
