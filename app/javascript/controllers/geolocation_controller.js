import { Controller } from '@hotwired/stimulus';
import { getDistance, convertDistance } from 'geolib';
import { isEmpty } from 'lodash-es';

export default class extends Controller {

  static targets = ['property']
  connect() {
    let lat = ""
    let lon = ""
    if(isEmpty(this.element.dataset.latitude) && isEmpty(this.element.dataset.longitude)) {
      window.navigator.geolocation.getCurrentPosition((position) => {
        lat = position.coords.latitude
        lon = position.coords.longitude
      })
    } else {
      lat = this.element.dataset.latitude
      lon = this.element.dataset.longitude
    }
    this.propertyTargets.forEach((propertyTarget) => {
      let distanceFrom = getDistance(
        { latitude: lat, longitude: lon },
        { latitude: propertyTarget.dataset.latitude, longitude: propertyTarget.dataset.longitude }
      );
      propertyTarget.querySelector('[data-distance-away]').innerHTML = `${convertDistance(distanceFrom, 'km').toFixed()} kilometers away`;
    });
  }
}