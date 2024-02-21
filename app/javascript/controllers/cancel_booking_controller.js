import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("faefa");
  }
  initialize() {
    this.element.setAttribute("data-action", "click->cancel-booking#showModal");
  }
  showModal(event){
    event.preventDefault();
    this.url = this.element.getAttribute("href")
    console.log(this.url);
    fetch(this.url, {
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    } )
    .then(Response => Response.text())
    .then(html => Turbo.renderStreamMessage(html))
  }
}
