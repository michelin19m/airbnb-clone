import { Controller } from '@hotwired/stimulus';
import { getDistance, convertDistance } from 'geolib';
import { isEmpty } from 'lodash-es';

export default class extends Controller {

  static targets = ['property']
  connect() {
    if(isEmpty(this.element.dataset.latitude) && isEmpty(this.element.dataset.longitude)) {
      this.setUserCoordinates();
    }
    this.setDisplayText()
  }

  setUserCoordinates() {
    window.navigator.geolocation.getCurrentPosition((position) => {
      this.element.dataset.latitude = position.coords.latitude
      this.element.dataset.longitude = position.coords.longitude
    })
  }

  getUserCoordinates() {
    return {
      latitude: this.element.dataset.latitude,
      longitude: this.element.dataset.longitude
    }
  }

  setDisplayText() {
    this.propertyTargets.forEach((propertyTarget) => {
      let distanceFrom = getDistance(
        this.getUserCoordinates(),
        { latitude: propertyTarget.dataset.latitude, longitude: propertyTarget.dataset.longitude }
      );
      propertyTarget.querySelector('[data-distance-away]').innerHTML = `${convertDistance(distanceFrom, 'km').toFixed()} kilometers away`;
    });
  }
}