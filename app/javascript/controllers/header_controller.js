import { Controller } from "@hotwired/stimulus"
import {toggle} from "el-transition"

export default class extends Controller {
  static targets = ['openUserMenu', 'userAuthLink']

  connect() {
    this.openUserMenuTarget.addEventListener('click', this.toggleDropdownMenu)
    this.userAuthLinkTargets.forEach((link) => {
      link.addEventListener('click', () => {
        document.getElementById('user-auth-modal-trigger').click();
      })
    });

  }

  toggleDropdownMenu() {
    toggle(document.getElementById('dropdownContent'));
  }
}
