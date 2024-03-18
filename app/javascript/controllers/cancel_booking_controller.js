import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cancel-booking"
export default class extends Controller {
  static targets = [ "close" ]
  connect() {
  }

  initialize() {
    if (this.linkTarget) {
      this.linkTarget.setAttribute("data-action", "click->cancel-booking#showModal");
    }
  }
  showModal(event){
    event.preventDefault();
    this.url = this.element.getAttribute("href")
    fetch(this.url, {
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    } )
    .then(Response => Response.text())
    .then(html => Turbo.renderStreamMessage(html))
  }
  submit(event) {
    event.preventDefault();
    this.url = this.element.getAttribute("action");
    var formData = new FormData(this.element);
    fetch(this.url, {
        method: 'POST',
        body: formData,
        headers: {
            'Accept': 'text/vnd.turbo-stream.html'
        }
    })
    .then(async response => {
      if (response.status !== 422) {
          this.closeTarget.click();
          const html = await response.text();
          Turbo.renderStreamMessage(html);
      } else {
          const html_1 = await response.text();
          Turbo.renderStreamMessage(html_1);
          throw new Error('Validation Error');
      }
      })
    .catch(error => {
        if (error.message !== 'Validation Error') {
            console.error('Error:', error);
        } else {
            console.error('Validation Error occurred');
        }
    });
}
}
