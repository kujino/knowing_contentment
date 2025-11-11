import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    // hide メソッドをイベントから安全に呼べるように bind
    this.boundHide = this.hide.bind(this)
    window.addEventListener("click", this.boundHide)
  }

  disconnect() {
    window.removeEventListener("click", this.boundHide)
  }

  toggle(event) {
    event.stopPropagation()
    this.menuTarget.classList.toggle("hidden")
  }

  hide(event) {
    // メニュー外をクリックした時だけ閉じる
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden")
    }
  }
}