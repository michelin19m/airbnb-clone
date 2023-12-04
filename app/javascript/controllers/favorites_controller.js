import { Controller } from '@hotwired/stimulus'
import axios from 'axios'
import { csrfToken } from '../utils/csrf';

export default class extends Controller {
  HEADERS = { 'Content-Type': 'application/json', 'Accept': 'application/json', 'X-CSRF-Token': csrfToken() }

  favorite() {
    if(this.element.dataset.userLoggedIn === 'false') {
      return document.querySelector('[data-header-target="userAuthLink"').click()
    }

    if(this.element.dataset.favorited === 'true') {
      this.unfavoriteProperty();
    } else {
      this.favoriteProperty();
    }
  }

  getFavoritePath() {
    return '/api/favorites';
  }

  getUnfavoritePath(favoriteId) {
    return `/api/favorites/${favoriteId}`;
  }

  favoriteProperty() {
    axios.post(this.getFavoritePath(), {
      user_id: this.element.dataset.userId,
      property_id: this.element.dataset.propertyId
    }, {
      headers: this.HEADERS
    }).then((response) => {
      this.element.dataset.favorited = 'true';
      this.element.dataset.favoriteId = response.data.id;
      this.element.setAttribute('fill', '#FF5A5F');
    });
  }

  unfavoriteProperty() {
    axios.delete(this.getUnfavoritePath(this.element.dataset.favoriteId), {
      headers: this.HEADERS
    }).then((response) => {
      this.element.setAttribute('fill', 'rgba(0, 0, 0, 0.5)');
      this.element.dataset.favorited = 'false'
      this.element.dataset.favoriteId = '';
    })
  }
}