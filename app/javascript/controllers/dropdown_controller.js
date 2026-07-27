import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle", "menu"]

  connect() {
    this.close = this.close.bind(this)
    document.addEventListener("click", this.close)
  }

  disconnect() {
    document.removeEventListener("click", this.close)
  }

  toggle(event) {
    event.preventDefault()
    event.stopPropagation()
    this.element.classList.toggle("open")
    this.toggleTarget.setAttribute("aria-expanded", this.element.classList.contains("open"))
  }

  close(event) {
    if (event && event.type === "click" && this.element.contains(event.target)) return

    this.element.classList.remove("open")
    this.toggleTarget.setAttribute("aria-expanded", "false")
  }
}
