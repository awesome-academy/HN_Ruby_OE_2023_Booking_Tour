import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bs-modal"
export default class extends Controller {
  connect() {
    console.log("connect modal");
    this.modal = new bootstrap.Modal(this.element, {
      keyboard: false,
    } )
    this.modal.show()
  }
  disconnet() {
    console.log("disconnect modal");
    this.modal.hide()
  }
  submitEnd(event) {
    this.modal.hide()
  }
}
