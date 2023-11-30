import { Controller } from "@hotwired/stimulus";
import axios from 'axios';

export default class extends Controller {
  
  static targets = ['email', 'submit'];
  connect() {
    this.submitTarget.addEventListener('click', (e) => {
      e.preventDefault()
      if(!(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(this.emailTarget.value))) {
        document.getElementById('email-span').classList.remove('hidden')
      } else {
        axios.get("/api/users_by_email", {
          params: {
            email: this.emailTarget.value,
            format: 'json'
          }
        }).then((response) => {
          Turbo.visit('/users/sign_in')
        }).catch((response) => {
          Turbo.visit('/users/sign_up')
        })
      }
    })
  }

  
}