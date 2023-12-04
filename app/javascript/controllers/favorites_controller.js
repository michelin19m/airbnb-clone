import { Controller } from '@hotwired/stimulus'
import axios from 'axios'
import { csrfToken } from '../utils/csrf';

export default class extends Controller {
  favorite() {
    if(this.element.dataset.userLoggedIn === 'false') {
      return document.querySelector('[data-header-target="userAuthLink"').click()
    }

    if(this.element.dataset.favorited === 'true') {
      axios.delete(this.element.dataset.unfavoriteUrl, {
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-CSRF-Token': csrfToken()
        }
      })
      .then((response) => {
        this.element.setAttribute('fill', 'rgba(0, 0, 0, 0.5)');
        this.element.dataset.favorited = 'false'
      })
    } else {
      axios.post(this.element.dataset.favoriteUrl, {
        user_id: this.element.dataset.userId,
        property_id: this.element.dataset.propertyId
      }, {
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-CSRF-Token': csrfToken()
        }
      })
      .then((response) => {
        this.element.dataset.favorited = 'true'
        this.element.setAttribute('fill', '#FF5A5F');
      })
    }
  }
}