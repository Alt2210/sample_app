import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle", "menu"]

  connect() {
    this.close = this.close.bind(this)
    document.addEventListener("click", this.close)
    document.addEventListener("click", this.close)
    window.addEventListener("dropdown:opened", this.handleOtherOpened)
  }

  disconnect() {
    document.removeEventListener("click", this.close)
  }

  toggle(event) {
    event.preventDefault()
    event.stopPropagation()
    const isOpening = !this.element.classList.contains("open")

    if (isOpening) {
      window.dispatchEvent(new CustomEvent("dropdown:opened", { detail: { openElement: this.element } }))
    }

    this.element.classList.toggle("open", isOpening)
    this.toggleTarget.setAttribute("aria-expanded", isOpening)
  }

  handleOtherOpened(event) {
    if (event.detail.openElement !== this.element) {
      this.forceClose()
    }
  }

  close(event) {
    if (event && event.type === "click" && this.element.contains(event.target)) return

    this.forceClose()
  }

  forceClose() {
    this.element.classList.remove("open")
    if (this.hasToggleTarget) {
      this.toggleTarget.setAttribute("aria-expanded", "false")
    }
  }
}
