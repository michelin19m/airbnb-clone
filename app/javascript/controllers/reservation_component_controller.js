import { Controller } from '@hotwired/stimulus';
import axios from 'axios';

export default class extends Controller {
  // HEADERS = { 'Content-Type': 'application/json', 'Accept': 'application/json' }

  static targets = ['checkin', 'checkout', 'calculatedPrice', 'days', 'airbnbFee', 'total']

  connect() {}

  calculatePrice(days) {
    return days * this.element.dataset.pricePerNight;
  }

  calculateDays() {
    let startDate = new Date(this.checkinTarget.value);
    let endDate = new Date(this.checkoutTarget.value);

    // Calculate the difference in milliseconds
    let differenceInTime = endDate.getTime() - startDate.getTime();

    // Calculate the number of days by dividing the difference by milliseconds in a day
    let differenceInDays = differenceInTime / (1000 * 3600 * 24);

    let days = Math.floor(differenceInDays);
    this.daysTarget.innerHTML = days
    return days;
  }

  displayPrice() {
    let days = this.calculateDays();
    let price = this.calculatePrice(days);
    let fullStayAirbnbFee = Math.round(this.element.dataset.airbnbFee * price);
    let cleaningFee = parseInt(this.element.dataset.cleaningFee);
    this.calculatedPriceTarget.innerHTML = `$${price}`;
    this.airbnbFeeTarget.innerHTML = `$${fullStayAirbnbFee}`;
    this.totalTarget.innerHTML = `$${price + fullStayAirbnbFee + cleaningFee}`;
  }

  validateDateRange() {
    if(this.checkinTarget.value !== '' && this.checkoutTarget.value !== '') {
      axios.get('/api/properties/2/check_availability', {
        params: {
          checkin_date: this.checkinTarget.value,
          checkout_date: this.checkoutTarget.value,
          format: 'json'
        }
      })
      .then((response) => {
        this.displayPrice()
      })
    } else {
      
    }
  }
}